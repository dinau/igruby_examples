# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imspinner'

class ImColorInt < FFI::Struct
  layout(
    :x, :int,
    :y, :int,
    :z, :int,
    :w, :int
  )
end


#----------
# gui_main
#----------
def gui_main(window)
  # Setup fonts
  setupFonts()

  # Other definitions
  red   = ImColor.create(255, 0, 0)

  colorFunc = Proc.new do |intensity|
    h = FFIfloat.new
    s = FFIfloat.new
    v = FFIfloat.new
    ImGui::ColorConvertRGBtoHSV(intensity * 0.25, 0.8, 0.8, h.addr, s.addr, v.addr)
    col = ImColor.new
    col[:Value][:x] = h.read
    col[:Value][:y] = s.read
    col[:Value][:z] = v.read
    col[:Value][:w] = 1.0
    col
  end

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

    begin
      ImGui::Begin("ImSpinner demo in C++               " , nil)
      ImSpinner::demoSpinners()
    ensure
      ImGui::End()
    end

    #-----------------------
    # Show ImSpinner window
    #-----------------------
    begin
      ImGui::Begin("ImSpinner in Ruby  " + ICON_FA_SPINNER , nil)
        ImSpinner::DnaDotsEx(       "DnaDots",  16, 2, red, 1.2, 8, 0.25, true); ImGui::SameLine()
        ImSpinner::FadeTris(        "fadetris", 16);                             ImGui::SameLine()
        ImSpinner::Ang8(            "Ang8",     16, 2);                          ImGui::SameLine()
        ImSpinner::Clock(           "Clock",    16, 2);                          ImGui::SameLine()
        ImSpinner::Atom(            "atom",     16, 2);                          ImGui::SameLine()
        ImSpinner::SwingDots(       "wheel",    16, 6);                          ImGui::SameLine()
        ImSpinner::DotsToBar(       "tobar",    16, 2, 0.5);                     ImGui::SameLine()
        ImSpinner::BarChartRainbow( "rainbow",  16, 4, red, 4);                  ImGui::SameLine()
        ImSpinner::Camera(          "camera",   16, 7, colorFunc)
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
      window = createImGui(title:"ImGui: Ruby window", titleBarIcon:"./res/r.png")
      gui_main(window)
    ensure
      window.destroyImGui() # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
