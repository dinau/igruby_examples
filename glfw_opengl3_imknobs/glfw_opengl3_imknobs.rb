# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imknobs'
require_relative '../libs/imspinner'

 #------
 # main
 #------
def main()
  window = createImGui(title:"Dear ImGui: Ruby window 2025/09", titleBarIcon:__dir__ + "/res/r.png")

  # Setup fonts
  setupFonts()


  # For Input Text
  sbuf_size = 1024
  sBuf =  FFI::MemoryPointer.new(:char, sbuf_size)

  # For showing / hiding window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, false)
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

  # FrameBordeerSize
  style = ImGuiStyle.new(ImGui::GetStyle())
  style[:FrameBorderSize] = 1.0

  # Other definitions
  pio = ImGuiIO.new(ImGui::GetIO())

  sRubyImGuiVersion = getRubyImGuiVersion()

  red = ImColor.create(255,0,0,255)

  # For ImKnobs
  val1 = FFI::MemoryPointer.new(:float)
  val1.write_float(0)
  val2 = FFI::MemoryPointer.new(:float)
  val2.write_float(0)
  val3 = FFI::MemoryPointer.new(:float)
  val3.write_float(0)
  val4 = FFI::MemoryPointer.new(:float)
  val4.write_float(0)
  val5 = FFI::MemoryPointer.new(:int)
  val5.write_int(0)
  val6 = FFI::MemoryPointer.new(:float)
  val6.write_float(0)

  #-----------
  # main loop
  #-----------
  while GLFW.WindowShouldClose( window.handle ) == 0
    GLFW.PollEvents()

    newFrame()

    # Show window for Dear ImGui official demo
    if fShowDemoWindow.read(:bool)
      ImGui::ShowDemoWindow(fShowDemoWindow)
    end

    #-----------------------
    # Show ImKnobs window
    #-----------------------
    begin
      ImGui::Begin("ImKnobs in Ruby  " + ICON_FA_CAT , nil)
        if ImGui::KnobEx("Gain", val1, -6.0, 6.0, 0.1, "%.1fdB", ImGui::IgKnobVariant_Tick, 0, 0, 10, -1, -1 )
            # value was changed
        end
        ImGui::SameLine()

        if ImGui::KnobEx("Mix", val2, -1.0, 1.0, 1.0, "%.1f", ImGui::IgKnobVariant_Stepped, 0, 0, 10, -1, -1 )
            # value was changed
        end
        if ImGui::IsItemActive() and ImGui::IsMouseDoubleClicked(0)
          val2.write_float(0)
        end
        ImGui::SameLine()

        # Custom colors
        ImGui::PushStyleColor_Vec4(ImGuiCol_ButtonActive,  ImVec4.create(255.0, 0,     0, 0.7))
        ImGui::PushStyleColor_Vec4(ImGuiCol_ButtonHovered, ImVec4.create(255.0, 0,     0, 1))
        ImGui::PushStyleColor_Vec4(ImGuiCol_Button,        ImVec4.create(0,     255.0, 0, 1))
        if ImGui::KnobEx("Pitch", val3, -6.0, 6.0, 0.1, "%.1f", ImGui::IgKnobVariant_WiperOnly, 0, 0, 10, -1, -1)

        end
        ImGui::PopStyleColor(3)
        ImGui::SameLine()

        # Custom min/max angle
        if ImGui::KnobEx("Dry", val4, -6.0, 6.0, 0.1, "%.1f", ImGui::IgKnobVariant_Stepped, 0, 0, 10, 1.570796, 3.141592)

        end
        ImGui::SameLine()


        if ImGui::KnobIntEx("Wet", val5, 1, 10, 0.1, "%i", ImGui::IgKnobVariant_Stepped, 0, 0, 10, -1, -1)
          #window.ini.window.colBGy = @as(f32,@floatFromInt(st.val5)) / 10.0;
        end
        ImGui::SameLine()


        # Vertical drag only
        if ImGui::KnobEx("Vertical", val6, 0.0, 10.0, 0.1, "%.1f", ImGui::IgKnobVariant_Space, 0, ImGui::IgKnobFlags_DragVertical, 10, -1, -1)

        end
        ImGui::NewLine()
        ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])
    ensure
      ImGui::End()
    end

    #-----------------------
    # Show ImSpinner window
    #-----------------------
    begin
      ImGui::Begin("ImSpinner in Ruby  " + ICON_FA_DOG , nil)
        ImGui::SpinnerDnaDotsEx("DnaDots", 16, 2, red, 1.2, 8, 0.25, true); ImGui::SameLine()
        ImGui::SpinnerFadeTris("fadetris", 16); ImGui::SameLine()
        ImGui::SpinnerAng8("Ang8", 16, 2); ImGui::SameLine()
        ImGui::SpinnerAtom("atom", 16, 2); ImGui::SameLine()
        ImGui::SpinnerBarChartRainbow("rainbow", 16, 4, red, 4);
        ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])
    ensure
      ImGui::End()
    end

    #------------------
    # Show info window
    #------------------
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

      ImGui::ColorEdit3("Background color", window.ini.clearColor)
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])

    ensure
      ImGui::End() # Window end proc
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
