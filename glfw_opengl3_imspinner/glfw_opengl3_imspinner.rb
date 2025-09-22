# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imspinner'


 #------
 # main
 #------
def main()
  window = createImGui(title:"Dear ImGui: Ruby window", titleBarIcon:__dir__ + "/res/r.png")

  # Setup fonts
  setupFonts()


  # For Input Text
  sbuf_size = 1024
  sBuf =  FFI::MemoryPointer.new(:char, sbuf_size)

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, false)
  fShowAboutDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowAboutDemoWindow.write(:bool, false)

  # For theme color
  fToggleTheme = FFI::MemoryPointer.new(:bool)
  theme, sTheme =  getTheme(window)
  if theme == Theme::Light
    fToggleTheme.write(:bool, true)
  else
    fToggleTheme.write(:bool, false)
  end

  # FrameBordeerSize
  style = ImGuiStyle.new(ImGui::GetStyle())
  style[:FrameBorderSize] = 1.0

  # Other definitions
  pio = ImGuiIO.new(ImGui::GetIO())

  sRubyImGuiVersion = getRubyImGuiVersion()

  red = ImColor.create(255,0,0,255)

  #-----------
  # main loop
  #-----------
  while GLFW.WindowShouldClose( window.handle ) == 0
    GLFW.PollEvents()

    newFrame()

    # Show window for Dear ImGui official demo
    if fShowDemoWindow.read(:bool)
      ImGui::ShowDemoWindow(fShowDemoWindow)
    end
    if fShowAboutDemoWindow.read(:bool)
      ImGuiDemo::ShowAboutWindow(fShowAboutDemoWindow)
    end

    begin
      ImGui::Begin("ImSpinner demo in C++               " , nil)
      ImGui::demoSpinners()
    ensure
      ImGui::End()
    end

    #-----------------------
    # Show ImSpinner window
    #-----------------------
    begin
      ImGui::Begin("ImSpinner in Ruby  " + ICON_FA_DOG , nil)
        ImGui::SpinnerDnaDotsEx(       "DnaDots",  16, 2, red, 1.2, 8, 0.25, true); ImGui::SameLine()
        ImGui::SpinnerFadeTris(        "fadetris", 16);                             ImGui::SameLine()
        ImGui::SpinnerAng8(            "Ang8",     16, 2);                          ImGui::SameLine()
        ImGui::SpinnerClock(           "Clock",    16, 2);                          ImGui::SameLine()
        ImGui::SpinnerAtom(            "atom",     16, 2);                          ImGui::SameLine()
        ImGui::SpinnerSwingDots(       "wheel",    16, 6);                          ImGui::SameLine()
        ImGui::SpinnerDotsToBar(       "tobar",    16, 2, 0.5);                     ImGui::SameLine()
        ImGui::SpinnerBarChartRainbow("rainbow",   16, 4, red, 4);
        ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])
    ensure
      ImGui::End()
    end

    #----------------------------------
    # Show main window in left topside
    #----------------------------------
    begin
      ImGui::Begin("Dear ImGui window in Ruby  " + ICON_FA_WIFI + " 2025/02", nil)

      # Toggle button for selecting theme
      if ImGui::ToggleButton("Theme", fToggleTheme)
        if fToggleTheme.read(:bool)
          sTheme = setTheme(window, Theme::Light)
        else
          sTheme = setTheme(window, Theme::Dark)
        end
      end
      ImGui::SameLine()
      ImGui::Text(sTheme)

      # Show version info
      ImGui::Text(ICON_FA_APPLE_WHOLE  + "  Ruby:  %s",       :string, RUBY_VERSION)
      ImGui::Text(ICON_FA_MUSIC        + "  ImGui-Ruby:  %s", :string, sRubyImGuiVersion)
      ImGui::Text(ICON_FA_PAGER        + "  Dear ImGui:  %s", :string, ImGui::GetVersion().read_string)
      ImGui::Text(ICON_FA_DISPLAY      + "  GLFW:  v%s",      :string, getFrontendVersionString())
      ImGui::Text(ICON_FA_CUBES        + "  OpenGL:  v%s",    :string, getBackendVersionString())

      ImGui::ColorEdit3("Background color", window.ini.clearColor)
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])

    ensure
      ImGui::End() # Window end proc
    end

    # Render
    render(window)

  end # end main loop

  # Free resources
  destroyImGui(window)
end

if __FILE__ == $PROGRAM_NAME
  main()
end
