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
  pio = ImGuiIO.new(ImGui::GetIO())

  # For ImKnobs
  val1 = FFI::MemoryPointer.new(:float)
  val1.write_float(0)
  val2 = FFI::MemoryPointer.new(:float)
  val2.write_float(0)
  val3 = FFI::MemoryPointer.new(:float)
  val3.write_float(0)
  val4 = FFI::MemoryPointer.new(:float)
  val4.write_float(0)
  val5 = FFI::MemoryPointer.new(:int)
  val5.write_int(0)
  val6 = FFI::MemoryPointer.new(:float)
  val6.write_float(0)

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
        if ImKnobs::KnobEx("Gain", val1, -6.0, 6.0, 0.1, "%.1fdB", ImKnobs::IgKnobVariant_Tick, 0, 0, 10, -1, -1 )
            # value was changed
        end
        ImGui::SameLine()

        if ImKnobs::KnobEx("Mix", val2, -1.0, 1.0, 1.0, "%.1f", ImKnobs::IgKnobVariant_Stepped, 0, 0, 10, -1, -1 )
            # value was changed
        end
        if ImGui::IsItemActive() and ImGui::IsMouseDoubleClicked(0)
          val2.write_float(0)
        end
        ImGui::SameLine()

        # Custom colors
        ImGui::PushStyleColor_Vec4(ImGuiCol_ButtonActive,  ImVec4.create(255.0, 0,     0, 0.7))
        ImGui::PushStyleColor_Vec4(ImGuiCol_ButtonHovered, ImVec4.create(255.0, 0,     0, 1))
        ImGui::PushStyleColor_Vec4(ImGuiCol_Button,        ImVec4.create(0,     255.0, 0, 1))
        if ImKnobs::KnobEx("Pitch", val3, -6.0, 6.0, 0.1, "%.1f", ImKnobs::IgKnobVariant_WiperOnly, 0, 0, 10, -1, -1)

        end
        ImGui::PopStyleColor(3)
        ImGui::SameLine()

        # Custom min/max angle
        if ImKnobs::KnobEx("Dry", val4, -6.0, 6.0, 0.1, "%.1f", ImKnobs::IgKnobVariant_Stepped, 0, 0, 10, 1.570796, 3.141592)

        end
        ImGui::SameLine()

        if ImKnobs::KnobIntEx("Wet", val5, 1, 10, 0.1, "%i", ImKnobs::IgKnobVariant_Stepped, 0, 0, 10, -1, -1)
          #window.ini.window.colBGy = @as(f32,@floatFromInt(st.val5)) / 10.0;
        end
        ImGui::SameLine()

        # Vertical drag only
        if ImKnobs::KnobEx("Vertical", val6, 0.0, 10.0, 0.1, "%.1f", ImKnobs::IgKnobVariant_Space, 0, ImKnobs::IgKnobFlags_DragVertical, 10, -1, -1)

        end
        ImGui::NewLine()
        ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])
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
