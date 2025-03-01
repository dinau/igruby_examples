# coding: utf-8
#
require_relative '../utils/appImGui'

#----------
# gui_main
#----------
def gui_main(window)

  setTheme(window, Theme::Classic)

  # Setup fonts
  setupFonts()

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, true)

  # Other definitions
  counter = 0
  pio = ImGuiIO.new(ImGui::GetIO())
  sRubyImGuiVersion = getRubyImGuiVersion()

  #-----------
  # main loop
  #-----------
  while GLFW.WindowShouldClose( window.handle ) == 0
    GLFW.PollEvents()

    newFrame()

    # Show ImGui demo window
    ImGui::ShowDemoWindow(fShowDemoWindow)

    #----------------------------------
    # Show main window in left side
    #----------------------------------
    begin
      ImGui::Begin("ImGui ウィンドウ in Ruby  " + ICON_FA_WIFI + " 2025/02", nil)

      # Show version info
      ImGui::Text(ICON_FA_APPLE_WHOLE  + "  Ruby:  %s",       :string, RUBY_VERSION)
      ImGui::Text(ICON_FA_MUSIC        + "  ImGui-Ruby:  %s", :string, sRubyImGuiVersion)
      ImGui::Text(ICON_FA_PAGER        + "  Dear ImGui:  %s", :string, ImGui::GetVersion().read_string)
      ImGui::Text(ICON_FA_DISPLAY      + "  GLFW:  v%s",      :string, getFrontendVersionString())
      ImGui::Text(ICON_FA_CUBES        + "  OpenGL:  v%s",    :string, getBackendVersionString())

      # Show some widgets
      ImGui::ColorEdit3("背景色", window.ini.clearColor)
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])

      if ImGui::Button("ボタン") # Button for counter
        counter += 1
      end
      ImGui::SameLine()
      ImGui::Text("counter = %d", :int, counter)

    ensure
      ImGui::End()     # Window end
    end

    # Render
    render(window)

  end # end while loop
end

#------
# main
#------
def main()
    begin
      window = createImGui(title:"ImGui: Ruby window", titleBarIcon:__dir__ + "/res/r.png")
      gui_main(window)
    ensure
      destroyImGui(window) # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
