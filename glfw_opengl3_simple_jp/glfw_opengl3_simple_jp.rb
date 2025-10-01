# coding: utf-8
#
require_relative '../utils/appImGui'

#----------
# gui_main
#----------
def gui_main(window)

  # Setup fonts
  setupFonts()

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, true)

  # Other definitions
  counter = 0
  pio = ImGuiIO.new(ImGui::GetIO())

  #-----------
  # main loop
  #-----------
  while window.shouldClose()
    window.pollEvents()

    # Iconify sleep
    if window.isIconified()
        next
    end
    window.newFrame()

    # Show ImGui demo window
    if fShowDemoWindow.read(:bool)
      ImGui::ShowDemoWindow(fShowDemoWindow)
    end

    #----------------------------------
    # Show main window in left side
    #----------------------------------
    ImGui::Begin("ImGui ウィンドウ in Ruby  " + ICON_FA_WIFI + " 2025/02", nil)
    begin
      # Show version info
      ImGui::Text(ICON_FA_APPLE_WHOLE  + "  Ruby:  %s",       :string, RUBY_VERSION)
      #ImGui::Text(ICON_FA_MUSIC        + "  ImGui-Ruby:  %s", :string, sRubyImGuiVersion)
      ImGui::Text(ICON_FA_PAGER        + "  Dear ImGui:  %s", :string, ImGui::GetVersion().read_string)
      ImGui::Text(ICON_FA_DISPLAY      + "  GLFW:  v%s",      :string, window.getFrontendVersionString())
      ImGui::Text(ICON_FA_CUBES        + "  OpenGL:  v%s",    :string, window.getBackendVersionString())

      # Show some widgets
      ImGui::Checkbox("ImGui demo", fShowDemoWindow)
      ImGui::ColorEdit3("背景色", window.getBackgroundColorPtr())
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
    window.render()

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
      window.destroyImGui() # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
