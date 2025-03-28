# coding: utf-8
#
require 'rake'
require_relative './setup_dll'
require_relative './setup_opengl_dll'
require_relative './setupFonts'
require_relative './loadImage'
require_relative './zoomglass'
require_relative './togglebutton'
require_relative './about_window'
require_relative './utils'
#require_relative './impl_glfw'
#require_relative './impl_opengl3'


if defined? RubyVM::YJIT.enable
  RubyVM::YJIT.enable
end


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

Window = Struct.new(\
                    :handle,
                    :context,
                    :imnodes,
                    :showWindowDelay,
                    :ini
                   )

#-------------
# createImGui
#-------------
def createImGui(imnodes:false, title:"Ruby-ImGui window", titleBarIcon:__dir__ + "/r.png")
  window = Window.new
  window.ini = IniData.new
  # Background color
  window.ini.clearColor = FFI::MemoryPointer.new(:float, 3)
  loadIni(window)

  GLFW.load_lib(SampleUtil.glfw_library_path)
  if GLFW.Init() == GL::FALSE
    puts("Failed to init GLFW.")
    exit
  end

  window.handle = 0
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
    window.handle = GLFW.CreateWindow(window.ini.viewportWidth, window.ini.viewportHeight, title, nil, nil)
    break unless window.handle.null?
  end

  if window.handle == 0
    GLFW.Terminate()
    exit()
  end
  GLFW.SetWindowPos(window.handle, window.ini.startupPosX, window.ini.startupPosY)

  GLFW.SetErrorCallback(CbErrorcb)
  GLFW.SetKeyCallback( window.handle, CbKey )

  # Init
  GLFW.MakeContextCurrent( window.handle )
  GLFW.SwapInterval(1)

  GL.load_lib()

  ImGui::CreateContext()

  glsl_version = "#version " + (ver_major * 100 + ver_minor * 10).to_s
  ImGui::ImplGlfw_InitForOpenGL(window.handle, true)
  ImGui::ImplOpenGL3_Init(glsl_version)

  # Set window Icon
  LoadTitleBarIcon(window.handle, titleBarIcon)

  # Other variables
  window.showWindowDelay = 5

  # Set theme
  Theme::setTheme(window.ini.theme)

  # FrameBordeerSize
  style = ImGuiStyle.new(ImGui::GetStyle())
  style[:FrameBorderSize] = 1.0

  return window
end

#--------------
# destroyImGui
#--------------
def destroyImGui(window)
  saveIni(window)
  ImGui::ImplOpenGL3_Shutdown()
  ImGui::ImplGlfw_Shutdown()
  #when defined(ImNodesEnable):
  #  if window.imnodes:
  #    imnodes_DestroyContext(nil)
  ImGui::DestroyContext()
  GLFW.DestroyWindow(window.handle)
  GLFW.Terminate()
end

#--------
# render
#--------
def render(window)
    ImGui::Render()
    GLFW.MakeContextCurrent( window.handle )

    width_buf = ' ' * 8
    height_buf = ' ' * 8
    GLFW.GetFramebufferSize(window.handle, width_buf, height_buf)
    width = width_buf.unpack1('L')
    height = height_buf.unpack1('L')
    GL.Viewport(0, 0, width, height)

    # Set background color
    ary3 = window.ini.clearColor.get_array_of_float(0, 3)
    GL.ClearColor(ary3[0], ary3[1], ary3[2], 1.00)
    #
    GL.Clear(GL::COLOR_BUFFER_BIT)
    ImGui::ImplOpenGL3_RenderDrawData(ImGui::GetDrawData())

    GLFW.SwapBuffers( window.handle )

    # Avoid flickering window at start up: TODO
    if window.showWindowDelay >=0
      window.showWindowDelay -= 1
    end
    if window.showWindowDelay == 0
      GLFW.ShowWindow(window.handle)
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

def getFrontendVersionString() GLFW.GetVersionString().to_s end
def getBackendVersionString() GL.GetString(GL::VERSION).to_s end

require 'json'

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

#---------
# loadIni    --- Load iniFile
#---------
def loadIni(win)
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
  win.ini.startupPosX = dtj
  dtj = jsdata[:window][:startupPosY]; raise eMsg if nil == dtj
  dtj = 10 if (10 > dtj) or (dtj > 10000)
  win.ini.startupPosY = dtj

  # Window size
  dtj = jsdata[:window][:viewportWidth]; raise eMsg if nil == dtj
  dtj = 900 if 100 > dtj
  win.ini.viewportWidth = dtj
  dtj = jsdata[:window][:viewportHeight]; raise eMsg if nil == dtj
  dtj = 900 if 100 > dtj
  win.ini.viewportHeight = dtj

  # Background color
  dtj = jsdata[:window][:colBGx]; raise eMsg if nil == dtj
  x = dtj
  dtj = jsdata[:window][:colBGy]; raise eMsg if nil == dtj
  y = dtj
  dtj = jsdata[:window][:colBGz]; raise eMsg if nil == dtj
  z = dtj
  win.ini.clearColor.put_array_of_float(0, [x, y, z])

  # Image format index
  dtj = jsdata[:image][:imageSaveFormatIndex]; raise eMsg if nil == dtj
  win.ini.imageSaveFormatIndex = dtj

  # Theme
  dtj = jsdata[:window][:theme]; raise eMsg if nil == dtj
  win.ini.theme = dtj
end

#---------
# saveIni   --- save iniFile
#---------
def saveIni(win)
  baseName = File.basename($PROGRAM_NAME.ext(".ini"))
  iniName = File.join(Dir.pwd, baseName)

  jsdata = JSON.parse(DefaultJson, options = {symbolize_names: true})

  # Window pos
  x = ' ' * 4
  y = ' ' * 4
  GLFW.GetWindowPos(win.handle, x ,y)
  jsdata[:window][:startupPosX] = x.unpack1('L')
  jsdata[:window][:startupPosY] = y.unpack1('L')

  # Window size
  ws = ImGuiViewport.new(ImGui::GetMainViewport())[:WorkSize]
  jsdata[:window][:viewportWidth]  = ws[:x]
  jsdata[:window][:viewportHeight] = ws[:y]

  # Background color
  ary3 = win.ini.clearColor.get_array_of_float(0, 3)
  jsdata[:window][:colBGx] = ary3[0]
  jsdata[:window][:colBGy] = ary3[1]
  jsdata[:window][:colBGz] = ary3[2]

  # Image format index
  jsdata[:image][:imageSaveFormatIndex] = win.ini.imageSaveFormatIndex

  # Theme
  jsdata[:window][:theme] = win.ini.theme

  # Save ini data
  File.open(iniName, mode = "w"){|fp|
    fp.write(JSON.pretty_generate(jsdata))
  }
end

#----------
# setTheme
#----------
def setTheme(win, theme)
  win.ini.theme = theme
  Theme::setTheme(theme)
end

#----------
# getTheme
#----------
def getTheme(win)
  theme = win.ini.theme
  return theme, Theme::getThemeString(theme)
end
