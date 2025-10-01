# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imcolortextedit'

#------
# main
#------
def gui_main(window)

  # Setup fonts
  setupFonts()

  # For ImImColorTextEdit
  # This is a programing font. https://github.com/yuru7/NOTONOTO
  fontFullPath = "./fonts/notonoto_v0.0.3/NOTONOTO-Regular.ttf"
  fileName = "main.cpp"
  sBuffer = File.read(fileName, encoding: "UTF-8")
  editor = ImGuiColorTextEdit.TextEditor()
  ImGuiColorTextEdit.SetLanguageDefinition(editor, ImGuiColorTextEdit::Cpp)
  ImGuiColorTextEdit.SetText(editor, sBuffer)
  ImGuiColorTextEdit.SetPalette(editor, ImGuiColorTextEdit::Dark) # Dark, Light, etc

  mLine = FFI::MemoryPointer.new(:int)
  mColumn =FFI::MemoryPointer.new(:int)
  fQuit = false

  pio = ImGuiIO.new(ImGui::GetIO())
  # Setup programing fonts
  textPoint = 14.5
  textFont = pio[:Fonts].AddFontFromFileTTF(fontFullPath, 19, nil, nil)

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

    window.infoWindow()

    #-------------------------------
    # Show ImImColorTextEdit window
    #-------------------------------
    ImGui::Begin("ImImColorTextEdit in Ruby  " + ICON_FA_CAT + " 2025/09" , nil, ImGuiWindowFlags_HorizontalScrollbar | ImGuiWindowFlags_MenuBar)
    begin
      ImGuiColorTextEdit.GetCursorPosition(editor, mLine, mColumn)
      ImGui::SetWindowSize_Vec2(ImVec2.create(800, 600), ImGuiCond_FirstUseEver)
      if ImGui::BeginMenuBar()
        begin
          #-------------
          #-- Menu File
          #-------------
          if ImGui::BeginMenu("File")
            begin
              if ImGui::MenuItem_BoolPtr(ICON_FA_FLOPPY_DISK + " Save", "Ctrl-S", FFI::Pointer::NULL)
                sBuffer = ImGuiColorTextEdit.GetText(editor)
                #--writeFile("main.cpp", strText)
                #print"saved"
              end
              if ImGui::MenuItem_Bool(ICON_FA_SQUARE_PLUS + " Quit", "Alt-F4")
                fQuit = true
              end
            ensure
              ImGui::EndMenu()
            end
          end
          #-------------
          #-- Menu Edit
          #-------------
          if ImGui::BeginMenu("Edit", true)
            begin
              ro = FFI::MemoryPointer.new(:bool)
              ro.write(:bool, ImGuiColorTextEdit.IsReadOnlyEnabled(editor))
              if ImGui::MenuItem_BoolPtr(ICON_FA_LOCK + " Read-only mode", "", ro)
                ImGuiColorTextEdit.SetReadOnlyEnabled(editor, ro.read(:bool))
              end
              ImGui::Separator()
              if ImGui::MenuItem_BoolPtr(ICON_FA_ARROW_ROTATE_LEFT + " Undo", "ALT-Backspace", nil, !ro.read(:bool) && ImGuiColorTextEdit.CanUndo(editor))
                ImGuiColorTextEdit.Undo(editor, 1)
              end
              if ImGui::MenuItem_BoolPtr(ICON_FA_ARROW_ROTATE_RIGHT + " Redo", "Ctrl-Y", nil, !ro.read(:bool) && ImGuiColorTextEdit.CanRedo(editor))
                ImGuiColorTextEdit.Redo(editor, 1)
              end
              ImGui::Separator()
              if ImGui::MenuItem_BoolPtr(ICON_FA_COPY + " Copy", "Ctrl-C", nil, ImGuiColorTextEdit.AnyCursorHasSelection(editor))
                ImGuiColorTextEdit.Copy(editor)
              end
              if ImGui::MenuItem_BoolPtr(ICON_FA_SCISSORS + " Cut", "Ctrl-X", nil, !ro.read(:bool) && ImGuiColorTextEdit.AnyCursorHasSelection(editor))
                ImGuiColorTextEdit.Cut(editor)
              end
              if ImGui::MenuItem_BoolPtr(ICON_FA_PASTE + " Paste", "Ctrl-V", nil, !ro.read(:bool) && ImGui::GetClipboardText() != nil)
                ImGuiColorTextEdit.Paste(editor)
              end
              ImGui::Separator()
              if ImGui::MenuItem_Bool(ICON_FA_SQUARE + " Select all", "Ctrl-A")
                ImGuiColorTextEdit.SelectAll(editor)
              end
            ensure
              ImGui::EndMenu()
            end
          end
          #-------------
          #-- Menu Theme
          #-------------
          if ImGui::BeginMenu("Theme", true)
            begin
              if ImGui::MenuItem_Bool(ICON_FA_STAR_AND_CRESCENT + " Dark palette", nil)
                ImGuiColorTextEdit.SetPalette(editor, ImGuiColorTextEdit::Dark)
              end
              if ImGui::MenuItem_Bool(ICON_FA_SUN + " Light palette", nil)
                ImGuiColorTextEdit.SetPalette(editor, ImGuiColorTextEdit::Light)
              end
              if ImGui::MenuItem_Bool(ICON_FA_M + " Mariana palette", nil)
                ImGuiColorTextEdit.SetPalette(editor, ImGuiColorTextEdit::Mariana)
              end
              if ImGui::MenuItem_Bool(ICON_FA_CAMERA_RETRO + " Retro blue palette", "Ctrl-B")
                ImGuiColorTextEdit.SetPalette(editor, ImGuiColorTextEdit::RetroBlue)
              end
            ensure
              ImGui::EndMenu()
            end
          end
        ensure
          ImGui::EndMenuBar()
        end
      end #-- menubar end

      langNames = [ "None", "Cpp", "C", "Cs", "Python", "Lua", "Json", "Sql", "AngelScript", "Glsl", "Hlsl" ]
      str1 =  "Ins"
      if ImGuiColorTextEdit.IsOverwriteEnabled(editor)
        str1 =  "Ovr"
      end
      str2 = ""
      if ImGuiColorTextEdit.CanUndo(editor)
        str2 =  "*"
      end
      ImGui::Text("%6d/%-6d %6d lines  | %s | %s | %s | %s",
                  :int, mLine.read_int() + 1, :int, mColumn.read_int() + 1, :int, ImGuiColorTextEdit.GetLineCount(editor),
                  :string, str1, :string, str2, :string, langNames[ImGuiColorTextEdit.GetLanguageDefinition(editor)], :string, fileName)

      ImGui::PushFont(textFont)
      ImGuiColorTextEdit.Render(editor, "texteditor", false, ImVec2.create(0, 0), false)
      ImGui::PopFont()
    ensure
      ImGui::End()
    end

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
      window = createImGui(title:"Dear ImGui: Ruby window 2025/09", titleBarIcon:__dir__ + "/res/r.png")
      gui_main(window)
    ensure
      window.destroyImGui() # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
