# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative './imDrawListParty'

#----------
# gui_main
#----------
def gui_main(window)

  # Setup fonts
  setupFonts()

  #-----------
  # main loop
  #-----------
  while window.shouldClose()
    window.pollEvents(0)

    # Iconify sleep
    if window.isIconified()
        next
    end
    window.newFrame()

    #-------------------
    # Show version info
    #-------------------
    window.infoWindow()

    #------------------
    # Show ImDrawParty
    #------------------
    ImGuiFX.fxTestBed("Curve", nil, ImGuiFX.method(:fxCurve))
    ImGuiFX.fxTestBed("Visual",nil, ImGuiFX.method(:fxVisual))

    # Render
    window.render()

  end # end main loop
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
