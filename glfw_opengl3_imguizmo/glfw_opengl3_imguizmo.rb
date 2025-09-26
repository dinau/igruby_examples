# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imguizmo'

#----------
# gui_main
#----------
def gui_main(window)

  window.ini.clearColor.put_array_of_float(0, [0.1, 0.1, 0.15])

  # Setup fonts
  setupFonts()

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, true)

  pio = ImGuiIO.new(ImGui::GetIO())

  zmo_op_ptr   = FFI::MemoryPointer.new(:int)
  zmo_op_ptr.write_int(ImGuizmo::TRANSLATE)
  zmo_mode_ptr = FFI::MemoryPointer.new(:int)
  zmo_mode_ptr.write_int(ImGuizmo::LOCAL)

  # bounds 6 floats
  zmobounds_ptr = FFI::MemoryPointer.new(:float, 6)
  zmobounds_ptr.write_array_of_float([-0.5, -0.5, -0.5, 0.5, 0.5, 0.5])

  # 16 floats
  m_ident_ptr = FFI::MemoryPointer.new(:float, 16).write_array_of_float([
    1,0,0,0,
    0,1,0,0,
    0,0,1,0,
    0,0,0,1
  ])

  mv_mo_ptr = FFI::MemoryPointer.new(:float, 16).write_array_of_float([
    1,0,0,0,
    0,1,0,0,
    0,0,1,0,
    0,0,-7,1
  ])

  mp_mo_ptr = FFI::MemoryPointer.new(:float, 16).write_array_of_float([
    2.3787,0,0,0,
    0,3.1716,0,0,
    0,0,-1.0002,-1,
    0,0,-0.2,0
  ])

  mo_mo_ptr = FFI::MemoryPointer.new(:float, 16).write_array_of_float([
    1,0,0,0,
    0,1,0,0,
    0,0,1,0,
    0.5,0.5,0.5,1
  ])

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

    ImGuizmo.BeginFrame()

    #----------------------
    # Show ImGuizmo window
    #----------------------
    begin
      ImGui::Begin("ImGuizmo window in Ruby  " + ICON_FA_WIFI + " 2025/09", nil)
      #
      ImGui.igRadioButton_IntPtr("trans", zmo_op_ptr,   ImGuizmo::TRANSLATE)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("rot",   zmo_op_ptr,   ImGuizmo::ROTATE)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("scale", zmo_op_ptr,   ImGuizmo::SCALE)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("bounds", zmo_op_ptr,  ImGuizmo::BOUNDS)
      ImGui.igRadioButton_IntPtr("local", zmo_mode_ptr, ImGuizmo::LOCAL)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("world", zmo_mode_ptr, ImGuizmo::WORLD)
    ensure
      ImGui::End() # Window end proc
    end

    # --- ImGuizmo drawing & manipulation ---
    ImGuizmo.SetRect(0.0, 0.0, pio[:DisplaySize][:x], pio[:DisplaySize][:y])
    ImGuizmo.SetOrthographic(false)
    ImGuizmo.DrawGrid(mv_mo_ptr, mp_mo_ptr, m_ident_ptr, 10)
    ImGuizmo.DrawCubes(mv_mo_ptr, mp_mo_ptr, mo_mo_ptr, 1)

    # read current zmo_op value (int) from memory
    current_op = zmo_op_ptr.read_int
    current_mode = zmo_mode_ptr.read_int

    pmp = (current_op == ImGuizmo::BOUNDS) ? zmobounds_ptr : nil

    ImGuizmo.Manipulate(mv_mo_ptr, mp_mo_ptr, current_op, current_mode, mo_mo_ptr, nil, nil, pmp, nil)

    pos_ptr = FFI::MemoryPointer.new(:float, 2).write_array_of_float([0.0, 0.0])
    size_ptr = FFI::MemoryPointer.new(:float, 2).write_array_of_float([128.0, 128.0])
    ImGuizmo.ViewManipulate_Float(mv_mo_ptr, 7.0, pos_ptr, size_ptr, 0x10101010)

    #--------
    # Render
    #--------
    render(window)

  end # end main loop

end

#------
# main
#------
def main()
    begin
      window = createImGui(title:"Dear ImGui: Ruby window", titleBarIcon:__dir__ + "/res/r.png")
      gui_main(window)
    ensure
      destroyImGui(window) # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
