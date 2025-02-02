# coding: utf-8
#
require_relative '../utils/setup_dll'
require_relative '../utils/setup_opengl_dll'
require_relative '../utils/setupFonts'
require_relative '../utils/loadImage'
require_relative '../utils/zoomglass'
require_relative '../utils/togglebutton'
require_relative '../utils/about_window'

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

$pfbWidth= FFI::MemoryPointer.new(:int)
$pfbHeight= FFI::MemoryPointer.new(:int)
CbFrameBufferResize = GLFW::create_callback(:GLFWframebuffersizefun) do |window, width, height|
  $pfbWidth.write_int(width)
  $pfbHeight.write_int(height)
end

#------
# main
#------
def main()
  w = 1024
  h = 920
  # Find Imgui-Ruby version from Gem folders
  sRubyImGuiVersion = Gem.find_files('imgui.dll')
  if sRubyImGuiVersion[0] =~ /\/(\w+\-\w+\-\d\.\d\.\d+)\-.+\// then
    sRubyImGuiVersion = $1
  end

  GLFW.load_lib(SampleUtil.glfw_library_path)
  if GLFW.Init() == GL::FALSE
    puts("Failed to init GLFW.")
    exit
  end

  window = 0
  versions = [[4, 5], [4, 4], [4, 3], [4, 2], [4, 1], [4, 0], [3, 3]]
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
    window = GLFW.CreateWindow(w, h, "Ruby-ImGui (GLFW+OpenGL3)", nil, nil)
    break unless window.null?
  end

  if window == 0
    GLFW.Terminate()
    exit()
  end

  GLFW.SetErrorCallback(CbErrorcb)
  GLFW.SetKeyCallback( window, CbKey )
  GLFW.SetFramebufferSizeCallback( window, CbFrameBufferResize )

  # Init
  GLFW.MakeContextCurrent( window )
  GLFW.SwapInterval(1)

  GL.load_lib()

  ImGui::CreateContext()

  glsl_version = "#version " + (ver_major * 100 + ver_minor * 10).to_s
  ImGui::ImplGlfw_InitForOpenGL(window, true)
  ImGui::ImplOpenGL3_Init(glsl_version)

  pio = ImGuiIO.new(ImGui::GetIO())
  japanese_font = setupFonts()

  # Set window Icon
  LoadTitleBarIcon(window, __dir__ + "/res/r.png")

  # Load image file
  pTextureID = ' ' * 4
  pTexWidth = ' ' * 4
  pTexHeight = ' ' * 4
  LoadTextureFromFile(__dir__ + "/img/himeji-400.jpg", pTextureID, pTexWidth, pTexHeight)

  # For theme color
  #ImGui::StyleColorsClassic()
  ImGui::StyleColorsDark()

  # For Input Text
  sbuf_size = 1024
  sBuf =  FFI::MemoryPointer.new(:char, sbuf_size)

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, true)
  fShowAboutDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowAboutDemoWindow.write(:bool, false)

  sTheme = "ダーク"
  fToggleTheme = FFI::MemoryPointer.new(:bool)
  fToggleTheme.write(:bool, false)

  # For Slider
  valf = FFI::MemoryPointer.new(:float)
  valf.write(:float, 0.33)

  # Background color
  aryf3 = FFI::MemoryPointer.new(:float, 3)
  aryf3.put_array_of_float(0, [0, 150/255.0, 200/255.0])

  # FrameBordeerSize
  style = ImGuiStyle.new(ImGui::GetStyle())
  style[:FrameBorderSize] = 1.0

  # Other variables
  showWindowDelay = 5 # TODO for avoiding flickering
  counter = 0
  width_buf = ' ' * 8
  height_buf = ' ' * 8

  #-----------
  # main loop
  #-----------
  while GLFW.WindowShouldClose( window ) == 0
    GLFW.PollEvents()

    ImGui::ImplOpenGL3_NewFrame()
    ImGui::ImplGlfw_NewFrame()
    ImGui::NewFrame()

    # Show window for Dear ImGui official demo
    if fShowDemoWindow.read(:bool) then
      ImGui::ShowDemoWindow(fShowDemoWindow)
    end
    if fShowAboutDemoWindow.read(:bool) then
      ImGuiDemo::ShowAboutWindow(fShowAboutDemoWindow)
    end

    # Show main window in left top side
    if true then
      ImGui::PushFont(japanese_font) # open font
      ImGui::Begin("ImGui ウィンドウ in Ruby  " + ICON_FA_WIFI + " 2025/02", nil)

      # Toggle button for selecting theme
      if ImGui::ToggleButton("テーマ", fToggleTheme) then
        if fToggleTheme.read(:bool) then
          ImGui::StyleColorsLight()
          sTheme = "ライト"
        else
          ImGui::StyleColorsDark()
          sTheme = "ダーク"
        end
      end
      ImGui::SameLine()
      ImGui::Text(sTheme)

      # Show version info
      ImGui::Text(ICON_FA_APPLE_WHOLE  + "  Ruby:  %s",       :string, RUBY_VERSION)
      ImGui::Text(ICON_FA_MUSIC        + "  ImGui-Ruby:  %s", :string, sRubyImGuiVersion)
      ImGui::Text(ICON_FA_PAGER        + "  Dear ImGui:  %s", :string, ImGui::GetVersion().read_string)
      ImGui::Text(ICON_FA_DISPLAY      + "  GLFW:  v%s",      :string, GLFW.GetVersionString().to_s)
      ImGui::Text(ICON_FA_CUBES        + "  OpenGL:  v%s",    :string, GL.GetString(GL::VERSION).to_s)

      # Show some widgets
      ImGui::InputTextWithHint("日本語を入力","ここに入力", sBuf ,sbuf_size)
      ImGui::Text("入力結果: ");ImGui::SameLine(); ImGui::Text(sBuf.read_string)
      ImGui::Checkbox("ImGui デモ", fShowDemoWindow); ImGui::SameLine()
      ImGui::Checkbox("About デモ", fShowAboutDemoWindow)
      ImGui::SliderFloat("浮動小数", valf, 0.0, 1.0)
      ImGui::ColorEdit3("背景色", aryf3)
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])

      # Button for counter
      if ImGui::Button("ボタン") then
        counter += 1
      end

      # Show overlay hint for Button
      if ImGui::IsItemHovered(ImGuiHoveredFlags_DelayShort) and ImGui::BeginTooltip() then
        ImGui::Text("*** ツールチップヘルプ  ***")
        ary = FFI::MemoryPointer.new(:float, 7)
        ary.put_array_of_float(0, [0.6, 0.1, 1.0, 0.5, 0.92, 0.1, 0.2])
        sz = ImVec2.create(0,0)
        ImGui::PlotLines("Curve" , ary , 7 , 0 , overlay_text = "Overlay string" , 0.0 , 1.0 , sz ,Fiddle::SIZEOF_FLOAT)
        ImGui::Text("Sin(time) = %.2f", :float, Math.sin(ImGui::GetTime()))
        ImGui::EndTooltip()
      end
      ImGui::SameLine()
      ImGui::Text("counter = %d", :int, counter)

      # Show icon fonts
      ImGui::SeparatorText(ICON_FA_WRENCH + " Icon font test ")
      ImGui::Text(ICON_FA_TRASH_CAN + " Trash")
      ImGui::Text(ICON_FA_MAGNIFYING_GLASS_PLUS +
        " " + ICON_FA_POWER_OFF +
        " " + ICON_FA_MICROPHONE +
        " " + ICON_FA_MICROCHIP +
        " " + ICON_FA_VOLUME_HIGH +
        " " + ICON_FA_SCISSORS +
        " " + ICON_FA_SCREWDRIVER_WRENCH +
        " " + ICON_FA_BLOG)
      #
      ImGui::End() # Window end proc
      ImGui::PopFont() # close font
    end

    # Show image window left down side
    if true then
      ImGui::PushFont(japanese_font) # open font
      ImGui::Begin("イメージ ウィンドウ", nil)
      # Load image
      width  = pTexWidth.unpack1('L')
      height = pTexHeight.unpack1('L')
      size = ImVec2.create(width, height)
      uv0 = ImVec2.create(0, 0)
      uv1 = ImVec2.create(1, 1)
      tint_col   = ImVec4.create(1, 1, 1, 1)
      border_col = ImVec4.create(0, 0, 0, 0)
      txid = FFI::MemoryPointer.new(:ImTextureID)
      txid.write_pointer(pTextureID.unpack1('L'))
      imageBoxPosTop = ImGui::GetCursorScreenPos() # Get absolute pos.
      ImGui::Image(txid.read_pointer, size, uv0, uv1, tint_col, border_col);
      # Zoom glass
      if ImGui::IsItemHovered(ImGuiHoveredFlags_DelayNone) then
        zoomGlass(txid.read_pointer, width, height, imageBoxPosTop)
      end
      #
      ImGui::End()
      ImGui::PopFont() # close font
    end

    # Render
    ImGui::Render()
    GLFW.MakeContextCurrent( window )

    #GLFW.GetFramebufferSize(window, pfbWidth, pfbHeight)
    GLFW.GetFramebufferSize(window, width_buf, height_buf)
    width = width_buf.unpack1('L')
    height = height_buf.unpack1('L')
    #GL.Viewport(0, 0, $pfbWidth.read_int, $pfbHeight.read_int)
    GL.Viewport(0, 0, width, height)

    # Set background color
    ary3 = aryf3.get_array_of_float(0, 3)
    GL.ClearColor(ary3[0], ary3[1], ary3[2], 1.00)
    #
    GL.Clear(GL::COLOR_BUFFER_BIT)
    ImGui::ImplOpenGL3_RenderDrawData(ImGui::GetDrawData())

    GLFW.SwapBuffers( window )

    # Avoid flickering window at start up: TODO
    if showWindowDelay >=0 then
      showWindowDelay -= 1
    end
    if showWindowDelay == 0 then
      GLFW.ShowWindow(window)
    end

  end # end main loop

  # Free resources
  GL::DeleteTextures(1, pTextureID)
  ImGui::ImplOpenGL3_Shutdown()
  ImGui::ImplGlfw_Shutdown()
  ImGui::DestroyContext(nil)

  GLFW.DestroyWindow(window)
  GLFW.Terminate()
end

if __FILE__ == $PROGRAM_NAME
  main()
end
