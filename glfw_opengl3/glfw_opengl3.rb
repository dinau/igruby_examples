# coding: utf-8
#
require_relative '../utils/appImGui'

#----------
# gui_main
#----------
def gui_main(window)

  # Setup fonts
  setupFonts()

  # Load image file
  pTextureID = ' ' * 4
  pTexWidth = ' ' * 4
  pTexHeight = ' ' * 4
  LoadTextureFromFile(__dir__ + "/img/anfield_liverpool_jiburi-400.gif", pTextureID, pTexWidth, pTexHeight)

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

    #-------------------
    # Show version info
    #-------------------
    window.infoWindow()

    #-------------------
    # Show image window
    #-------------------
    begin
      ImGui::Begin("Image window", nil)
      # Load image
      width          = pTexWidth.unpack1('L')
      height         = pTexHeight.unpack1('L')
      size           = ImVec2.create(width, height)
      uv0            = ImVec2.create(0, 0)
      uv1            = ImVec2.create(1, 1)
      tint_col       = ImVec4.create(1, 1, 1, 1)
      border_col     = ImVec4.create(0, 0, 0, 0)
      imageBoxPosTop = ImGui::GetCursorScreenPos() # Get absolute pos.
      ImGui::Image(pTextureID.unpack1('L'), size, uv0, uv1, tint_col, border_col);
      # Zoom glass
      if ImGui::IsItemHovered(ImGuiHoveredFlags_DelayNone)
        zoomGlass(pTextureID.unpack1('L'), width, height, imageBoxPosTop)
      end
    ensure
      ImGui::End()
    end

    # Render
    window.render()

  end # end main loop

  # Free resources
  GL::DeleteTextures(1, pTextureID)
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
