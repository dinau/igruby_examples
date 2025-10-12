# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imguizmo'

#----------
# gui_main
#----------
def gui_main(window)

  window.setBackgroundColor(0.1, 0.1, 0.12)

  # Setup fonts
  setupFonts()

  zmo_op   = FFIint.new(ImGuizmo::TRANSLATE)
  zmo_mode = FFIint.new(ImGuizmo::LOCAL)

  # bounds 6 floats
  zmobounds= FFIfloatArray.new([-0.5, -0.5, -0.5, 0.5, 0.5, 0.5], size: 6)

  # 16 floats
  m_ident = FFIfloatArray.new([1,0,0,0,
                               0,1,0,0,
                               0,0,1,0,
                               0,0,0,1 ], size: 16)

  mv_mo   = FFIfloatArray.new([1,0,0,0,
                               0,1,0,0,
                               0,0,1,0,
                               0,0,-7,1], size: 16)

  mp_mo   = FFIfloatArray.new([2.3787,0,0,0,
                               0,3.1716,0,0,
                               0,0,-1.0002,-1,
                               0,0,-0.2,0], size: 16)

  mo_mo   = FFIfloatArray.new([1,0,0,0,
                               0,1,0,0,
                               0,0,1,0,
                               0.5,0.5,0.5,1], size: 16)

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

    ImGuizmo.BeginFrame()

    #----------------------
    # Show ImGuizmo window
    #----------------------
    begin
      ImGui::Begin("ImGuizmo window in Ruby  " + ICON_FA_WIFI + " 2025/09", nil)
      #
      ImGui.igRadioButton_IntPtr("trans", zmo_op.addr,   ImGuizmo::TRANSLATE)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("rot",   zmo_op.addr,   ImGuizmo::ROTATE)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("scale", zmo_op.addr,   ImGuizmo::SCALE)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("bounds", zmo_op.addr,  ImGuizmo::BOUNDS)
      ImGui.igRadioButton_IntPtr("local", zmo_mode.addr, ImGuizmo::LOCAL)
      ImGui.igSameLine(0.0, -1.0)
      ImGui.igRadioButton_IntPtr("world", zmo_mode.addr, ImGuizmo::WORLD)
    ensure
      ImGui::End() # Window end proc
    end

    # --- ImGuizmo drawing & manipulation ---
    ImGuizmo.SetRect(0.0, 0.0, window.pio[:DisplaySize][:x], window.pio[:DisplaySize][:y])
    ImGuizmo.SetOrthographic(false)
    ImGuizmo.DrawGrid( mv_mo.addr, mp_mo.addr, m_ident.addr, 10)
    ImGuizmo.DrawCubes(mv_mo.addr, mp_mo.addr, mo_mo.addr  , 1)

    # read current zmo_op value (int) from memory
    current_op = zmo_op.read
    current_mode = zmo_mode.read

    pmp = (current_op == ImGuizmo::BOUNDS) ? zmobounds.addr : nil

    ImGuizmo.Manipulate(mv_mo.addr, mp_mo.addr, current_op, current_mode, mo_mo.addr, nil, nil, pmp, nil)

    pos  = FFIfloatArray.new([0.0, 0.0], size: 2)
    size = FFIfloatArray.new([129.0, 128.0], size: 2)
    ImGuizmo.ViewManipulate_Float(mv_mo.addr, 7.0, pos.addr, size.addr, 0x10101010)

    #--------
    # Render
    #--------
    window.render()

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
      window.destroyImGui() # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
