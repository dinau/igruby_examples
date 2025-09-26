# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imtoggle'

 #------
 # main
 #------
def main()
  window = createImGui(title:"Dear ImGui: Ruby window 2025/09", titleBarIcon:__dir__ + "/res/r.png")

  # Setup fonts
  setupFonts()

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, true)

  # For ImToggle
  green = ImVec4.create(0.16, 0.66, 0.45,1.0)
  green_hover = ImVec4.create(0.0, 1.0, 0.57, 1.0)
  green_shadow = ImVec4.create(0.0, 1.0, 0.0, 0.4)
  size = ImVec2.create(0,0)

  # State
  values = [true, true, true, true, true, true, true, true]

  #-----------
  # main loop
  #-----------
  while GLFW.WindowShouldClose( window.handle ) == 0
    window.pollEvents()

    # Iconify sleep
    if window.isIconified()
        next
    end
    newFrame()

    # Show window for Dear ImGui official demo
    if fShowDemoWindow.read(:bool)
      ImGui::ShowDemoWindow(fShowDemoWindow)
    end

    #----------------------
    # Show ImToggle window
    #----------------------
    begin
      ImGui::Begin("ImToggle in Ruby  " + ICON_FA_CAT + " 2025/09" , nil)

      value_index = 0

      # Default
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImToggle.Toggle('Default Toggle', value_ptr, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      value_index += 1

      # Animation
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Animated Toggle', value_ptr, ImToggle::ImGuiToggleFlags::Animated, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

      # Border
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Bordered Knob', value_ptr, ImToggle::ImGuiToggleFlags::Bordered, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      value_index += 1

      # Shadow
      ImGui.PushStyleColor_Vec4(ImGuiCol_BorderShadow, green_shadow)
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Shadowed Knob', value_ptr, ImToggle::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

      # Border + Shadow
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleAnim('Bordered + Shadowed Knob', value_ptr, ImToggle::ImGuiToggleFlags::Bordered | ImToggle::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1
      ImGui.PopStyleColor(1)

      # Green
      ImGui.PushStyleColor_Vec4(ImGuiCol_Button, green)
      ImGui.PushStyleColor_Vec4(ImGuiCol_ButtonHovered, green_hover)
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImToggle.Toggle('Green Toggle', value_ptr, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      ImGui.PopStyleColor(2)
      value_index += 1

      # A11y label
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImToggle.ToggleFlag('Toggle with A11y Labels', value_ptr, ImToggle::ImGuiToggleFlags::A11y, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

    ensure
      ImGui::End()
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
