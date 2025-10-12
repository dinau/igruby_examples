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
  value = FFIbool.new(true)

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
      value.set(values[value_index])
      ImToggle.Toggle('Default Toggle', value.addr, size)
      values[value_index] = value.read
      ImGui.SameLine()
      value_index += 1

      # Animation
      value.set(values[value_index])
      ImToggle.ToggleAnim('Animated Toggle', value.addr, ImToggle::ImGuiToggleFlags::Animated, 1.0, size)
      values[value_index] = value.read
      value_index += 1

      # Border
      value.set(values[value_index])
      ImToggle.ToggleAnim('Bordered Knob', value.addr, ImToggle::ImGuiToggleFlags::Bordered, 1.0, size)
      values[value_index] = value.read
      ImGui.SameLine()
      value_index += 1

      # Shadow
      ImGui.PushStyleColor_Vec4(ImGuiCol_BorderShadow, green_shadow)
      value.set(values[value_index])
      ImToggle.ToggleAnim('Shadowed Knob', value.addr, ImToggle::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value.read
      value_index += 1

      # Border + Shadow
      value.set(values[value_index])
      ImToggle.ToggleAnim('Bordered + Shadowed Knob', value.addr, ImToggle::ImGuiToggleFlags::Bordered | ImToggle::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value.read
      value_index += 1
      ImGui.PopStyleColor(1)

      # Green
      ImGui.PushStyleColor_Vec4(ImGuiCol_Button, green)
      ImGui.PushStyleColor_Vec4(ImGuiCol_ButtonHovered, green_hover)
      value.set(values[value_index])
      ImToggle.Toggle('Green Toggle', value.addr, size)
      values[value_index] = value.read
      ImGui.SameLine()
      ImGui.PopStyleColor(2)
      value_index += 1

      # A11y label
      value.set(values[value_index])
      ImToggle.ToggleFlag('Toggle with A11y Labels', value.addr, ImToggle::ImGuiToggleFlags::A11y, size)
      values[value_index] = value.read
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
