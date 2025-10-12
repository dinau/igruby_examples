# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imknobs'

#----------
# gui_main
#----------
def gui_main(window)

  # Setup fonts
  setupFonts()

  # Other definitions

  # For ImKnobs
  val1 = FFIfloat.new(0.25)
  val2 = FFIfloat.new(0.65)
  val3 = FFIfloat.new(0.85)
  val4 = FFIfloat.new(0.6)
  val5 = FFIint.new(1)
  val6 = FFIfloat.new(1.0)

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

    #-----------------------
    # Show ImKnobs window
    #-----------------------
    begin
      ImGui::Begin("ImKnobs in Ruby  " + ICON_FA_CAT , nil)
      if ImKnobs::Knob("Gain", val1.addr, -6.0, 6.0, 0.1, "%.1fdB", ImKnobs::IgKnobVariant_Tick)
        # value was changed
      end
      ImGui::SameLine()

      if ImKnobs::Knob("Mix", val2.addr, -1.0, 1.0, 0.1, "%.1f", ImKnobs::IgKnobVariant_Stepped)
        # value was changed
      end
      if ImGui::IsItemActive() and ImGui::IsMouseDoubleClicked(0)
        val2.set(0)
      end
      ImGui::SameLine()

      # Custom colors
      ImGui::PushStyleColor_Vec4(ImGuiCol_ButtonActive,  ImVec4.create(255.0, 0,     0, 0.7))
      ImGui::PushStyleColor_Vec4(ImGuiCol_ButtonHovered, ImVec4.create(255.0, 0,     0, 1))
      ImGui::PushStyleColor_Vec4(ImGuiCol_Button,        ImVec4.create(0,     255.0, 0, 1))
      if ImKnobs::Knob("Pitch", val3.addr, -6.0, 6.0, 0.1, "%.1f", ImKnobs::IgKnobVariant_WiperOnly)
        # value was changed
      end
      ImGui::PopStyleColor(3)
      ImGui::SameLine()

      # Custom min/max angle
      if ImKnobs::KnobEx("Dry", val4.addr, 0.0, 1.0, 0.1, "%.1f", ImKnobs::IgKnobVariant_Stepped, 0, 0, 10, 1.570796, 3.141592)
        # value was changed
      end
      ImGui::SameLine()

      if ImKnobs::KnobInt("Wet", val5.addr, 1, 10, 0.1, "%i", ImKnobs::IgKnobVariant_Stepped)
        # value was changed
      end
      ImGui::SameLine()

      # Vertical drag only
      if ImKnobs::KnobEx("Vertical", val6.addr, 0.0, 10.0, 0.1, "%.1f", ImKnobs::IgKnobVariant_Space, 0, ImKnobs::IgKnobFlags_DragVertical, 10, -1, -1)
        # value was changed
      end
      ImGui::NewLine()
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / window.pio[:Framerate], :float, window.pio[:Framerate])
    ensure
      ImGui::End()
    end

    #------------------
    # Show info window
    #------------------
    window.infoWindow()

    # Render
    window.render()

  end # end main loop
end

#------
# main
#------
def main()
  begin
    window = createImGui(title:"Dear ImGui: Ruby window 2025/09", titleBarIcon:__dir__ + "/res/r.png")
    gui_main(window)
  ensure
    window.destroyImGui() # Free resources
  end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
