# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative './iconFontsTblDef'
require_relative './iconFontsTbl2Def'

#----------
# gui_main
#----------
def gui_main(window)

  # Setup fonts
  setupFonts()

  # For Listbox
  item_current = FFI::MemoryPointer.new(:int)
  item_current.write(:int, 0)
  string_pointers = $IconFontsTbl.map { |str| FFI::MemoryPointer.from_string(str)}
  pIconFontsTbl   = FFI::MemoryPointer.new(:pointer, $IconFontsTbl.size)
  string_pointers.each_with_index do |ptr, i|
    pIconFontsTbl.put_pointer(i * FFI::Pointer.size, ptr)
  end

  # For Slider
  wsZoom = FFI::MemoryPointer.new(:float)
  wsZoom.write(:float, 2.5)

  filterAry = Array.new

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
    begin ImGui::Begin("Icon Font Viewer2", nil, 0)
      ImGui::Text("%s", :string, " Zoom x"); ImGui::SameLine(0,-1.0)
      ImGui::SliderFloat("##Zoom1", wsZoom, 0.8, 5.0, "%.1f", 0)
      ImGui::Separator()
      ImGui::BeginChild("child2", ImVec2.create(0,0), 0, 0)
      wsNormal = 1.0
      flags = ImGuiTableFlags_RowBg | ImGuiTableFlags_BordersOuter | ImGuiTableFlags_BordersV | ImGuiTableFlags_Resizable | ImGuiTableFlags_Reorderable | ImGuiTableFlags_Hideable
      text_base_height = ImGui::GetTextLineHeightWithSpacing()
      outer_size = ImVec2.create(0.0, text_base_height * 8)
      col = 10
      if ImGui::BeginTable("table_scrolly", col, flags, outer_size, 0)
        for row in 0...(1390 / col) do
          ImGui::TableNextRow(0, 0.0)
          for column in 0 ... col do
            ix = (row * col) + column
            ImGui::TableSetColumnIndex(column)
            ImGui::SetWindowFontScale(wsZoom.read(:float))
            ImGui::Text("%s", :string, $IconFontsTbl2[ix][0])
            if ImGui::IsItemHovered(0)
              item_current.write(:int, ix)
            end
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
      ImGui::EndChild()
    ensure
      ImGui::End()
    end

    #--------------------
    # Text filter window
    #--------------------
    begin
      ImGui::Begin("Icon Font filter", nil, 0)
      ImGui::Text("(Copy)");
      if ImGui::IsItemHovered(0)
        filterAry[0]  =~ /.+(ICON.+)/
        ImGui::SetClipboardText($1)
      end
      setTooltip("Copied first line to clipboard !") # Show tooltip help
      ImGui::SameLine()
      filterAry.clear
      filter = ImGuiTextFilter.create()
      filter.Draw("Filter")
      tbl = $IconFontsTbl
      for i in 0 ... tbl.size do
        pstr = FFI::MemoryPointer.from_string(tbl[i])
        if filter.PassFilter(pstr)
          ImGui::Text("[%04d]  %s", :int, i, :string, tbl[i])
          filterAry.push tbl[i]
        end
      end
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
      window = createImGui(title:"ImGui: Ruby window", titleBarIcon:__dir__ + "/res/r.png")
      gui_main(window)
    ensure
      window.destroyImGui() # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
