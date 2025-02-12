# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative './iconFontsTblDef'
require_relative './iconFontsTbl2Def'

#------
# main
#------
def main()
  window = createImGui(title:"ImGui: Ruby window", titleBarIcon:__dir__ + "/res/r.png")

  # Setup fonts
  setupFonts()

  # For showing demo window
  fShowDemoWindow = FFI::MemoryPointer.new(:bool)
  fShowDemoWindow.write(:bool, true)

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

  # For Listbox
  item_current = FFI::MemoryPointer.new(:int)
  item_current.write(:int, 0)
  string_pointers = $IconFontsTbl.map { |str| FFI::MemoryPointer.from_string(str)}
  pIconFontsTbl   = FFI::MemoryPointer.new(:pointer, $IconFontsTbl.size)
  string_pointers.each_with_index do |ptr, i|
    pIconFontsTbl.put_pointer(i * FFI::Pointer.size, ptr)
  end

  pio = ImGuiIO.new(ImGui::GetIO())
  sRubyImGuiVersion = getRubyImGuiVersion()

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

    #----------------------------------
    # Show version info window
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
      ImGui::Checkbox("ImGui demo", fShowDemoWindow)
      ImGui::ColorEdit3("Background color", window.ini.clearColor)
      ImGui::Text("Application average %.3f ms/frame (%.1f FPS)", :float, 1000.0 / pio[:Framerate], :float, pio[:Framerate])
    ensure
      ImGui::End() # Window end proc
    end

    #--------------
    # Show ListBox
    #--------------
    begin
      ImGui::Begin("Icon Font Viewer", nil, 0)
      ImGui::SeparatorText(ICON_FA_FONT_AWESOME + " Icon font view: " + $IconFontsTbl.length.to_s + " icons")
      #
      listBoxWidth = 340
      begin
        ImGui::Text("No.[%4d]", :int, item_current.read_int); ImGui::SameLine()
        sBuf = $IconFontsTbl[item_current.read_int]
        if ImGui::Button(ICON_FA_COPY + " Copy to", ImVec2.create(0, 0))
          if sBuf =~ /.+(ICON.+)/
            ImGui::SetClipboardText($1)
          end
        end
        setTooltip("Clipboard") # Show tooltip help
      end

      # Show ListBox header
      ImGui::SetNextItemWidth(listBoxWidth)
      ImGui::InputText("##", sBuf, sBuf.length, ImGuiInputTextFlags_None)

      # Show ListBox main
      ImGui::NewLine()
      ImGui::SetNextItemWidth(listBoxWidth)
      ImGui::ListBox("##lsitbox1", item_current, pIconFontsTbl, $IconFontsTbl.length, 30)
    ensure
      ImGui::End()
    end

    #---------------------
    # Show icons in Table
    #---------------------
    begin
      ImGui::Begin("Icon Font Viewer2", nil, 0)
      wsZoom = 2.5
      wsNormal = 1.0
      flags = ImGuiTableFlags_RowBg or ImGuiTableFlags_BordersOuter or ImGuiTableFlags_BordersV or ImGuiTableFlags_Resizable or ImGuiTableFlags_Reorderable or ImGuiTableFlags_Hideable
      text_base_height = ImGui::GetTextLineHeightWithSpacing()
      outer_size = ImVec2.create(0.0, text_base_height * 8)
      col = 10
      if ImGui::BeginTable("table_scrolly", col, flags, outer_size, 0)
        for row in 0...(1390 / col) do
          ImGui::TableNextRow(0, 0.0)
          for column in 0 ... col do
            ix = (row * col) + column
            ImGui::TableSetColumnIndex(column)
            ImGui::SetWindowFontScale(wsZoom)
            ImGui::Text("%s", :string, $IconFontsTbl2[ix][0])
            iconFontLabel = $IconFontsTbl2[ix][1]
            setTooltip(iconFontLabel)
            ImGui::SetWindowFontScale(wsNormal)
            #
            ImGui::PushID(ix)
            if ImGui::BeginPopupContextItem("Contex Menu", 1)
              if ImGui::MenuItem("Copy to clip board", "" , false, true)
                #puts "#{$IconFontsTbl2[ix][1]}"
                item_current.write(:int, ix)
                ImGui::SetClipboardText($IconFontsTbl2[ix][1])
              end
              ImGui::EndPopup()
            end
            ImGui::PopID()
          end
        end
        ImGui::EndTable()
      end
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
