# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imtoggle'

#----------
# gui_main
#----------
def gui_main(window)
  # Setup fonts
  setupFonts()

  # For ImToggle
  green = ImVec4.create(0.16, 0.66, 0.45,1.0)
  green_hover = ImVec4.create(0.0, 1.0, 0.57, 1.0)
  green_shadow = ImVec4.create(0.0, 1.0, 0.0, 0.4)
  size = ImVec2.create(0,0)

  # State
  values = [true, true, true, true, true, true, true, true]
  value_ptr = FFI::MemoryPointer.new(:bool, 1)
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

    window.infoWindow()

    #----------------------
    # Show ImToggle window
    #----------------------
    begin
      ImGui::Begin("ImToggle in Ruby  " + ICON_FA_CAT + " 2025/09" , nil)

      value_index = 0

      # Default
      value_ptr.write_uint8(values[value_index] ? 1 : 0)
      ImToggle.Toggle('Default Toggle', value_ptr, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      value_index += 1

      # Animation
      value_ptr.write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Animated Toggle', value_ptr, ImToggle::ImGuiToggleFlags::Animated, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

      # Border
      value_ptr.write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Bordered Knob', value_ptr, ImToggle::ImGuiToggleFlags::Bordered, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      value_index += 1

      # Shadow
      ImGui.PushStyleColor_Vec4(ImGuiCol_BorderShadow, green_shadow)
      value_ptr.write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Shadowed Knob', value_ptr, ImToggle::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

      # Border + Shadow
      value_ptr.write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Bordered + Shadowed Knob', value_ptr, ImToggle::ImGuiToggleFlags::Bordered | ImToggle::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1
      ImGui.PopStyleColor(1)

      # Green
      ImGui.PushStyleColor_Vec4(ImGuiCol_Button, green)
      ImGui.PushStyleColor_Vec4(ImGuiCol_ButtonHovered, green_hover)
      value_ptr.write_uint8(values[value_index] ? 1 : 0)
      ImToggle.Toggle('Green Toggle', value_ptr, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      ImGui.PopStyleColor(2)
      value_index += 1

      # A11y label
      value_ptr.write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleFlag('Toggle with A11y Labels', value_ptr, ImToggle::ImGuiToggleFlags::A11y, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

    ensure
      ImGui::End()
    end

    # Render
    window.render()

  end # end main loop
end

#------
# main
#------
def main()
    begin
      window = createImGui(title:"ImGui: Ruby window", titleBarIcon:"./res/r.png")
      gui_main(window)
    ensure
      window.destroyImGui() # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
