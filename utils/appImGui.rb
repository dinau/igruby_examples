# coding: utf-8
#
require 'rake'
require 'opengl'
require 'glfw'
require 'json'

#--- Specify 'imgui.dll' (CImGui + GLFW + Opengl3) ---
require_relative '../libs/imgui_dll'
ImGui_DLL.name = 'imgui.dll'
require_relative '../libs/setup_dll'
#-----------------------------------------------------

#require_relative '../libs/setup_opengl_dll'
require_relative './setupFonts'
require_relative './loadImage'
require_relative './zoomglass'
require_relative './togglebutton'
require_relative './utils'
require_relative '../libs/impl_glfw'
require_relative '../libs/impl_opengl3'

DefaultJson = <<EOF
{
  "window":{
    "startupPosX":400,
    "startupPosY":80,
    "viewportWidth":1024,
    "viewportHeight":900,
    "colBGx": 0.25,
    "colBGy": 0.65,
    "colBGz": 0.85,
    "theme": 0
  },
  "image":{
    "imageSaveFormatIndex": 0
  }
}
EOF

def check_error( desc )
  e = GL.GetError()
  if e != GL::NO_ERROR
    $stderr.printf "OpenGL error in \"#{desc}\": e=0x%08x\n", e.to_i
    exit
  else
    $stderr.printf "OpenGL no error in \"#{desc}\"\n", e.to_i
  end
end


#--------------------
# Registor callcacks
#--------------------
CbErrorcb = GLFW::create_callback(:GLFWerrorfun) do |error, desc|
  printf("GLFW error %d: %s\n", error, desc)
end

# Press ESC to exit.
CbKey = GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
  if key == GLFW::KEY_ESCAPE && action == GLFW::PRESS
    puts "Exited: ESC"
    GLFW.SetWindowShouldClose(window, GL::TRUE)
  end
end

IniData = Struct.new(\
                     :clearColor,
                     :startupPosX,
                     :startupPosY,
                     :viewportWidth,
                     :viewportHeight,
                     :imageSaveFormatIndex,
                     :theme
                    )

#-------------
# createImGui
#-------------
def createImGui(title:"Ruby-ImGui window", titleBarIcon:__dir__ + "/r.png")
   Window.new(title, titleBarIcon)
end

Null = Fiddle::Pointer.new(0)
class Window
  def initialize(title, titleBarIcon)
    @ini = IniData.new
    # Background color
    @ini.clearColor = FFI::MemoryPointer.new(:float, 3)
    self.loadIni()

    #GLFW.load_lib(SampleUtil.glfw_library_path)
    GLFW.load_lib(get_glfw_dll_path(__method__))
    if GLFW.Init() == GL::FALSE
      puts("Failed to init GLFW.")
      exit
    end

    versions = [[4, 6],[4, 5], [4, 4], [4, 3], [4, 2], [4, 1], [4, 0], [3, 3]]
    ver_major = 0
    ver_minor = 0
    versions.each do |version|
      ver_major = version[0]
      ver_minor = version[1]
      GLFW.DefaultWindowHints()
      GLFW.WindowHint(GLFW::OPENGL_FORWARD_COMPAT, GLFW::TRUE)
      GLFW.WindowHint(GLFW::OPENGL_PROFILE, GLFW::OPENGL_CORE_PROFILE)
      GLFW.WindowHint(GLFW::CONTEXT_VERSION_MAJOR, ver_major)
      GLFW.WindowHint(GLFW::CONTEXT_VERSION_MINOR, ver_minor)
      # Hide window at start up
      GLFW.WindowHint(GLFW::VISIBLE, GLFW::FALSE)
      @handle = GLFW.CreateWindow(@ini.viewportWidth, @ini.viewportHeight, title, Null, Null)
      if not @handle != Null
        break
      end
    end
    if @handle == Null
      GLFW.Terminate()
      puts "---------------------------"
      puts "Fail GLFW::createWindow()"
      puts "---------------------------"
      exit()
    end
    GLFW.SetWindowPos(@handle, @ini.startupPosX, @ini.startupPosY)

    GLFW.SetErrorCallback(CbErrorcb)
    GLFW.SetKeyCallback( @handle, CbKey )

    # Init
    GLFW.MakeContextCurrent( @handle )
    GLFW.SwapInterval(1) # Wait VSync

    GL.load_lib()

    ImGui::CreateContext()

    glsl_version = "#version " + (ver_major * 100 + ver_minor * 10).to_s
    windowHandleFFI = FFI::Pointer.new(@handle.to_i)
    ImGui::ImplGlfw_InitForOpenGL(windowHandleFFI, true)
    ImGui::ImplOpenGL3_Init(glsl_version)

    # Set window Icon
    LoadTitleBarIcon(@handle, titleBarIcon)

    # Other variables
    @showWindowDelay = 5

    @pio = ImGuiIO.new(ImGui::GetIO())

    self.setTheme(@ini.theme)

    # For theme color
    @fToggleTheme = FFI::MemoryPointer.new(:bool)
    @theme, @sTheme =  self.getTheme()
    if @theme == Theme::Light
      @fToggleTheme.write(:bool, true)
    else
      @fToggleTheme.write(:bool, false)
    end

    # For showing / hiding window
    @fShowDemoWindow = FFI::MemoryPointer.new(:bool)
    @fShowDemoWindow.write(:bool, false)
  end

  #--------------
  # destroyImGui
  #--------------
  def destroyImGui()
    saveIni()
    ImGui::ImplOpenGL3_Shutdown()
    ImGui::ImplGlfw_Shutdown()
    ImGui::DestroyContext()
    GLFW.DestroyWindow(@handle)
    GLFW.Terminate()
  end

  #---------------
  # getClearColor
  #---------------
  def getClearColor()
       @ini.clearColor
  end
  #--------
  # render
  #--------
  def render()
      ImGui::Render()
      GLFW.MakeContextCurrent( @handle )

      width_buf = ' ' * 8
      height_buf = ' ' * 8
      GLFW.GetFramebufferSize(@handle, width_buf, height_buf)
      width = width_buf.unpack1('L')
      height = height_buf.unpack1('L')
      GL.Viewport(0, 0, width, height)

      # Set background color
      ary3 = @ini.clearColor.get_array_of_float(0, 3)
      GL.ClearColor(ary3[0], ary3[1], ary3[2], 1.00)
      #
      GL.Clear(GL::COLOR_BUFFER_BIT)

      ImGui::ImplOpenGL3_RenderDrawData(ImGui::GetDrawData())

      GLFW.SwapBuffers( @handle )

      # Avoid flickering self at start up: TODO
      if @showWindowDelay >=0
        @showWindowDelay -= 1
      end
      if @showWindowDelay == 0
        GLFW.ShowWindow(@handle)
      end
  end

  #----------
  # newFrame
  #----------
  def newFrame()
      ImGui::ImplOpenGL3_NewFrame()
      ImGui::ImplGlfw_NewFrame()
      ImGui::NewFrame()
  end

  #-------------
  # isIconified
  #-------------
  def isIconified() # bool
    if 0 != GLFW.GetWindowAttrib(@handle, GLFW::GLFW_ICONIFIED)
      ImGui::ImplGlfw_Sleep(10)
      return true
    else
      return false
    end
  end

  #-----------
  # pollEvnet
  #-----------
  def pollEvents(*arg)
    if arg.length == 0
      GLFW.WaitEventsTimeout(1.0 / 60.0)  # Reduce CPU load
    else
      if arg[0] != 0
        GLFW.WaitEventsTimeout(arg[0])    # Sepcify CPU performance
      else
        GLFW.PollEvents()  # arg[0] == 0  # Use standard PollEvents()
      end
    end
  end

  #------------
  # infoWindow
  #------------
  def infoWindow()
    ImGui::Begin("Info window " + ICON_FA_CIRCLE_INFO, nil)
    begin
      # Toggle button for selecting theme
      if ImGui::ToggleButton("Theme", @fToggleTheme)
        if @fToggleTheme.read(:bool)
          @sTheme = self.setTheme(Theme::Light)
        else
          @sTheme = self.setTheme(Theme::Dark)
        end
      end
      ImGui::SameLine()
      ImGui::Text(@sTheme)
      ImGui::SameLine()
      ImGui::Checkbox("ImGui demo", @fShowDemoWindow)

      # Show version info
      ImGui::Text(ICON_FA_APPLE_WHOLE  + "  Ruby:  %s",       :string, RUBY_VERSION)
      #ImGui::Text(ICON_FA_MUSIC        + "  ImGui-Ruby:  %s", :string, sRubyImGuiVersion)
      ImGui::Text(ICON_FA_PAGER        + "  Dear ImGui:  %s", :string, ImGui::GetVersion().read_string)
      ImGui::Text(ICON_FA_DISPLAY      + "  GLFW:  v%s",      :string, getFrontendVersionString())
      ImGui::Text(ICON_FA_CUBES        + "  OpenGL:  v%s",    :string, getBackendVersionString())
      ImGui::ColorEdit3("Background color", @ini.clearColor)
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / @pio[:Framerate], :float, @pio[:Framerate])
    ensure
      ImGui::End() # Window end proc
    end

    # Show window for Dear ImGui official demo
    if @fShowDemoWindow.read(:bool)
      ImGui::ShowDemoWindow(@fShowDemoWindow)
    end
  end

  def getFrontendVersionString()
    GLFW.GetVersionString().to_s
  end
  def getBackendVersionString()
    GL.GetString(GL::VERSION).to_s
  end

  #---------
  # loadIni    --- Load iniFile
  #---------
  def loadIni()
    baseName = File.basename($PROGRAM_NAME.ext(".ini"))
    iniName = File.join(Dir.pwd, baseName)

    jsdata = nil
    if File.exist? iniName
      File.open(iniName, "rt"){ |fp|
        jsdata = fp.read
      }
      jsdata = JSON.parse(jsdata, options = {symbolize_names: true})
    else
      puts "Loaded: DefaultJson initial data"
      jsdata = JSON.parse(DefaultJson, options = {symbolize_names: true})
    end

    eMsg =  "Error!: in [[ #{iniName} ]]"

    # Window pos
    dtj = jsdata[:window][:startupPosX]; raise eMsg if nil == dtj
    dtj = 10 if (10 > dtj) or (dtj > 10000)
    @ini.startupPosX = dtj
    dtj = jsdata[:window][:startupPosY]; raise eMsg if nil == dtj
    dtj = 10 if (10 > dtj) or (dtj > 10000)
    @ini.startupPosY = dtj

    # Window size
    dtj = jsdata[:window][:viewportWidth]; raise eMsg if nil == dtj
    dtj = 900 if 100 > dtj
    @ini.viewportWidth = dtj
    dtj = jsdata[:window][:viewportHeight]; raise eMsg if nil == dtj
    dtj = 900 if 100 > dtj
    @ini.viewportHeight = dtj

    # Background color
    dtj = jsdata[:window][:colBGx]; raise eMsg if nil == dtj
    x = dtj
    dtj = jsdata[:window][:colBGy]; raise eMsg if nil == dtj
    y = dtj
    dtj = jsdata[:window][:colBGz]; raise eMsg if nil == dtj
    z = dtj
    @ini.clearColor.put_array_of_float(0, [x, y, z])

    # Image format index
    dtj = jsdata[:image][:imageSaveFormatIndex]; raise eMsg if nil == dtj
    @ini.imageSaveFormatIndex = dtj

    # Theme
    dtj = jsdata[:window][:theme]; raise eMsg if nil == dtj
    @ini.theme = dtj
  end

  #---------
  # saveIni   --- save iniFile
  #---------
  def saveIni()
    baseName = File.basename($PROGRAM_NAME.ext(".ini"))
    iniName = File.join(Dir.pwd, baseName)

    jsdata = JSON.parse(DefaultJson, options = {symbolize_names: true})

    # Window pos
    x = ' ' * 4
    y = ' ' * 4
    GLFW.GetWindowPos(@handle, x ,y)
    jsdata[:window][:startupPosX] = x.unpack1('L')
    jsdata[:window][:startupPosY] = y.unpack1('L')

    # Window size
    ws = ImGuiViewport.new(ImGui::GetMainViewport())[:WorkSize]
    jsdata[:window][:viewportWidth]  = ws[:x]
    jsdata[:window][:viewportHeight] = ws[:y]

    # Background color
    ary3 = @ini.clearColor.get_array_of_float(0, 3)
    jsdata[:window][:colBGx] = ary3[0]
    jsdata[:window][:colBGy] = ary3[1]
    jsdata[:window][:colBGz] = ary3[2]

    # Image format index
    jsdata[:image][:imageSaveFormatIndex] = @ini.imageSaveFormatIndex

    # Theme
    jsdata[:window][:theme] = @ini.theme

    # Save ini data
    File.open(iniName, mode = "w"){|fp|
      fp.write(JSON.pretty_generate(jsdata))
    }
  end

  #----------
  # setTheme
  #----------
  def setTheme(theme)
    @ini.theme = theme
    Theme::setTheme(theme)
  end

  #----------
  # getTheme
  #----------
  def getTheme()
    theme = @ini.theme
    return theme, Theme::getThemeString(theme)
  end

  #-------------
  # shouldClose
  #-------------
  def shouldClose()
    GLFW.WindowShouldClose(@handle) == 0
  end

  #---------------
  # setClearColor
  #---------------
  def setClearColor(r,g,b)
    @ini.clearColor.put_array_of_float(0, [r, g, b])
  end

  #--------------------
  # setBackgroundColor
  #--------------------
  def setBackgroundColor(r,g,b)
    setClearColor(r,g,b)
  end

  #-----------------------
  # getBackgroundColorPtr
  #-----------------------
  def getBackgroundColorPtr()
    @ini.clearColor
  end

  #--------------
  # swapInterval
  #--------------
  def swapInterval(n)
    GLFW.SwapInterval(n) # Wait VSync
  end

  #------------------------
  # getRubyImguiVersion
  #------------------------
  def getRubyImGuiVersion()
    # Find Imgui-Ruby version from Gem folders
    #sRubyImGuiVersion = Gem.find_files('imgui.dll') # very slow function
    #if sRubyImGuiVersion[0] =~ /\/(\w+\-\w+\-\d\.\d\.\d+)\-.+\// then
    #  sRubyImGuiVersion = $1
    #end
    #return sRubyImGuiVersion
    return "WIP"
  end
end


require 'fiddle'
require 'fiddle/import'

module WinAPI
  extend Fiddle::Importer
 dlload 'kernel32.dll'
  extern 'void* GetModuleHandleA(const char*)'
  extern 'unsigned long GetModuleFileNameA(void*, char*, unsigned long)'
end

def get_glfw_dll_path(place)
  # Get load info about glfw3.dll
  hmod = WinAPI.GetModuleHandleA('glfw3.dll')
  if hmod != 0
    buffer = "\0" * 2048
    WinAPI.GetModuleFileNameA(hmod, buffer, buffer.size)
    path = buffer.split("\0").first
    puts "glfw3.dll path: #{path} : #{place}"
  else
    puts "Not loaded glfw3.dll"
  end
  return path
end

#  sRubyImGuiVersion = getRubyImGuiVersion()
