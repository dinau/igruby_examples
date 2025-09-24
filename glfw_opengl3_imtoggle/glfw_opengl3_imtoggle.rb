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
  # 定数
  green = ImVec4.create(0.16, 0.66, 0.45,1.0)
  green_hover = ImVec4.create(0.0, 1.0, 0.57, 1.0)
  green_shadow = ImVec4.create(0.0, 1.0, 0.0, 0.4)
  size = ImVec2.create(0,0)

  # 状態管理
  values = [true, true, true, true, true, true, true, true]

  #-----------
  # main loop
  #-----------
  while GLFW.WindowShouldClose( window.handle ) == 0
    GLFW.PollEvents()

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

      # デフォルトトグル
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImGui.Toggle('Default Toggle', value_ptr, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      value_index += 1

      # アニメーショントグル
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImGui.ToggleAnim('Animated Toggle', value_ptr, ImGui::ImGuiToggleFlags::Animated, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

      # ボーダー付きノブ
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImGui.ToggleAnim('Bordered Knob', value_ptr, ImGui::ImGuiToggleFlags::Bordered, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      value_index += 1

      # シャドウ付きノブ
      ImGui.PushStyleColor_Vec4(ImGuiCol_BorderShadow, green_shadow)
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImGui.ToggleAnim('Shadowed Knob', value_ptr, ImGui::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1

      # ボーダー＋シャドウ付きノブ
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImGui.ToggleAnim('Bordered + Shadowed Knob', value_ptr, ImGui::ImGuiToggleFlags::Bordered | ImGui::ImGuiToggleFlags::Shadowed, 1.0, size)
      values[value_index] = value_ptr.read_uint8 == 1
      value_index += 1
      ImGui.PopStyleColor(1)

      # グリーントグル
      ImGui.PushStyleColor_Vec4(ImGuiCol_Button, green)
      ImGui.PushStyleColor_Vec4(ImGuiCol_ButtonHovered, green_hover)
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImGui.Toggle('Green Toggle', value_ptr, size)
      values[value_index] = value_ptr.read_uint8 == 1
      ImGui.SameLine()
      ImGui.PopStyleColor(2)
      value_index += 1

      # A11yラベル付きトグル
      value_ptr = FFI::MemoryPointer.new(:bool, 1).write_uint8(values[value_index] ? 1 : 0)
      ImGui.ToggleFlag('Toggle with A11y Labels', value_ptr, ImGui::ImGuiToggleFlags::A11y, size)
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
