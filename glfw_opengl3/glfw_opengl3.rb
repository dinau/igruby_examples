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
  LoadTextureFromFile(__dir__ + "/img/museum-400.png", pTextureID, pTexWidth, pTexHeight)

  # For Input Text
  sbuf_size = 1024
  sBuf =  FFI::MemoryPointer.new(:char, sbuf_size)

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, true)
  fShowAboutDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowAboutDemoWindow.write(:bool, false)

  # For theme color
  fToggleTheme = FFI::MemoryPointer.new(:bool)
  theme, sTheme =  getTheme(window)
  if theme == Theme::Light
    fToggleTheme.write(:bool, true)
  else
    fToggleTheme.write(:bool, false)
  end

  # For Slider
  valf = FFI::MemoryPointer.new(:float)
  valf.write(:float, 0.33)

  # FrameBordeerSize
  style = ImGuiStyle.new(ImGui::GetStyle())
  style[:FrameBorderSize] = 1.0

  # Other definitions
  counter = 0
  pio = ImGuiIO.new(ImGui::GetIO())

  sRubyImGuiVersion = getRubyImGuiVersion()

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
    if fShowAboutDemoWindow.read(:bool)
      ImGuiDemo::ShowAboutWindow(fShowAboutDemoWindow)
    end

    #----------------------------------
    # Show main window in left topside
    #----------------------------------
    begin
      ImGui::Begin("ImGui window in Ruby  " + ICON_FA_WIFI + " 2025/02", nil)

      # Toggle button for selecting theme
      if ImGui::ToggleButton("Theme", fToggleTheme)
        if fToggleTheme.read(:bool)
          sTheme = setTheme(window, Theme::Light)
        else
          sTheme = setTheme(window, Theme::Dark)
        end
      end
      ImGui::SameLine()
      ImGui::Text(sTheme)

      # Show version info
      ImGui::Text(ICON_FA_APPLE_WHOLE  + "  Ruby:  %s",       :string, RUBY_VERSION)
      ImGui::Text(ICON_FA_MUSIC        + "  ImGui-Ruby:  %s", :string, sRubyImGuiVersion)
      ImGui::Text(ICON_FA_PAGER        + "  Dear ImGui:  %s", :string, ImGui::GetVersion().read_string)
      ImGui::Text(ICON_FA_DISPLAY      + "  GLFW:  v%s",      :string, getFrontendVersionString())
      ImGui::Text(ICON_FA_CUBES        + "  OpenGL:  v%s",    :string, getBackendVersionString())

      # Show some widgets
      ImGui::InputTextWithHint("Text input","Input here", sBuf ,sbuf_size)
      ImGui::Text("Input result: ");ImGui::SameLine(); ImGui::Text(sBuf.read_string)
      ImGui::Checkbox("ImGui demo", fShowDemoWindow); ImGui::SameLine()
      ImGui::Checkbox("About demo", fShowAboutDemoWindow)
      ImGui::SliderFloat("float", valf, 0.0, 1.0)
      ImGui::ColorEdit3("Background color", window.ini.clearColor)
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])

      # Button for counter
      if ImGui::Button("Button")
        counter += 1
      end

      # Show overlay hint for Button
      if ImGui::IsItemHovered(ImGuiHoveredFlags_DelayShort) and ImGui::BeginTooltip()
        ImGui::Text("*** Tooltip help  ***")
        ary = FFI::MemoryPointer.new(:float, 7)
        ary.put_array_of_float(0, [0.6, 0.1, 1.0, 0.5, 0.92, 0.1, 0.2])
        sz = ImVec2.create(0,0)
        ImGui::PlotLines("Curve", ary, 7, 0, overlay_text = "Overlay string", 0.0, 1.0, sz, Fiddle::SIZEOF_FLOAT)
        ImGui::Text("Sin(time) = %.2f", :float, Math.sin(ImGui::GetTime()))
        ImGui::EndTooltip()
      end
      ImGui::SameLine()
      ImGui::Text("counter = %d", :int, counter)

      # Show icon fonts
      ImGui::SeparatorText(ICON_FA_WRENCH + " Icon font test ")
      ImGui::Text(ICON_FA_TRASH_CAN + " Trash")
      ImGui::Text(ICON_FA_MAGNIFYING_GLASS_PLUS +
        " " + ICON_FA_POWER_OFF +
        " " + ICON_FA_MICROPHONE +
        " " + ICON_FA_MICROCHIP +
        " " + ICON_FA_VOLUME_HIGH +
        " " + ICON_FA_SCISSORS +
        " " + ICON_FA_SCREWDRIVER_WRENCH +
        " " + ICON_FA_BLOG)
    ensure
      ImGui::End() # Window end proc
    end

    #---------------------------------
    # Show image window left downside
    #---------------------------------
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
    render(window)

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
      destroyImGui(window) # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
