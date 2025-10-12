# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imguifiledialog'

class App
  #----------
  # gui_main
  #----------
  def gui_main(window)
    # Setup fonts
    main_font = setupFonts()

    cfd = ImGuiFileDialog.Create()

    setFileStyle(cfd, main_font) # Colorization files

    sFilePathName = ""
    sFileDirPath  = ""
    sFilter       = ""
    sDatas        = ""

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

      #-----------------------------
      # Show ImGuiFileDialog window
      #-----------------------------
      ImGui::Begin("ImGuiFileDialog in Ruby  " + ICON_FA_FOLDER_OPEN)
      begin
        if ImGui::Button("OpenFile")
          config = ImGuiFileDialog.FileDialog_Config_Get()
          config[:path] = FFI::MemoryPointer.from_string(".")
          config[:flags] = ImGuiFileDialog::ImGuiFileDialogFlags_Modal |
                           ImGuiFileDialog::ImGuiFileDialogFlags_ShowDevicesButton |
                           ImGuiFileDialog::ImGuiFileDialogFlags_CaseInsensitiveExtentionFiltering
          ImGuiFileDialog.OpenDialog( cfd, "filedlg", "Open a File",
                                           "all (*){.*},c files(*.c *.h){.c,.h},Ruby (*.rb *.rbw){.rb,.rbw}",
                                           config)
        end
        #
        max_size = ImVec2.create()
        max_size[:x] = window.pio[:DisplaySize][:x] * 0.8
        max_size[:y] = window.pio[:DisplaySize][:y] * 0.8
        min_size = ImVec2.create()
        min_size[:x] = max_size[:x] * 0.25
        min_size[:y] = max_size[:y] * 0.25
        if ImGuiFileDialog.DisplayDialog(cfd, "filedlg", ImGuiWindowFlags_NoCollapse, min_size.pointer, max_size.pointer)
          if ImGuiFileDialog.IsOk(cfd)
            sFilePathName   = "?"
            pFilePathName   = ImGuiFileDialog.GetFilePathName(cfd, ImGuiFileDialog::ResultMode_AddIfNoFileExt)
            unless pFilePathName.null?
              sFilePathName = pFilePathName.read_string  # copy content of char* to Ruby string (Ruby heap region)
              ImGuiFileDialog.free(pFilePathName)        # free memory on the C side
            end
            sFileDirPath    = "?"
            pFileDirPath    = ImGuiFileDialog.GetCurrentPath(cfd)
            unless pFileDirPath.null?
              sFileDirPath  = pFileDirPath.read_string
              ImGuiFileDialog.free(pFileDirPath)
            end
            sFilter       = "?"
            pFilter       = ImGuiFileDialog.GetCurrentFilter(cfd)
            unless pFilter.null?
              sFilter       = pFilter.read_string
              ImGuiFileDialog.free(pFilter)
            end
            sDatas        = "?"
            pDatas        = ImGuiFileDialog.GetUserDatas(cfd)
            unless pDatas.null?
              sDatas        = pDatas.null? ? "" : pDatas.read_string
              ImGuiFileDialog.free(pDatas)
            end
          end
          ImGuiFileDialog.CloseDialog(cfd)
        end
        # Show selected path
        ImGui.igText("Selected file = %s", :string, sFilePathName)
        ImGui.igText("Dir           = %s", :string, sFileDirPath)
        ImGui.igText("Filter        = %s", :string, sFilter)
        ImGui.igText("Datas         = %s", :string, sDatas)
      ensure
        ImGui.igEnd()
      end

      #------------------
      # Show info window
      #------------------
      window.infoWindow()

      # Render
      window.render()
    end # end main loop

    ImGuiFileDialog.Destroy(cfd)
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

  def initialize
    main()
  end

  #--------------
  # setFileStyle
  #--------------
  def setFileStyle(cfd, pFont)
    clGreen      = ImVec4.create(0,             1,             0,             1)
    clMDseagreen = ImVec4.create(60.0 / 255.0,  179.0 / 255.0, 113.0 / 255.0, 1)

    clYellow     = ImVec4.create(1,             1,             0,             1)
    clOrange     = ImVec4.create(1,             165.0 / 255.0, 0,             1)

    clWhite2     = ImVec4.create(0.98,          0.98,          1,             1)
    clWhite      = ImVec4.create(1,             0,             1,             1)

    clPurple     = ImVec4.create(1,             51.0/255.0,    1,             1)
    clPurple2    = ImVec4.create(1,             161.0/255.0,   1,             1)

    clCyan       = ImVec4.create(0,             1,             1,             1)
    clSkyblue    = ImVec4.create(135.0 / 255.0, 206.0 / 255.0, 235.0 / 255.0, 1)
    clIndigo     = ImVec4.create(75.0 / 255.0,  0,             130.0 / 255.0, 1)
    clMoccasin   = ImVec4.create(1,             228.0 / 255.0, 181.0 / 255.0, 1)
    clRosybrown  = ImVec4.create(188.0/255.0,   143.0/255.0,   143.0/255.0,   1)

    #clSteelblue = ImVec4.create(70.0/255.0,   130.0/255.0, 180.0/255.0, 1)

    byExt = ImGuiFileDialog::FileStyleByExtention
    # Ruby
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".rb",         clCyan,       ICON_FA_GEM,            pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".rbw",        clPurple,     ICON_FA_GEM,            pFont)
    # Other
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".bat",        clCyan,       ICON_FA_PERSON_RUNNING, pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".pdb",        clYellow,     ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".exe",        clCyan,       ICON_FA_PLANE,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".EXE",        clCyan,       ICON_FA_PLANE,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".nim",        clSkyblue,    ICON_FA_N,              pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".nelua",      clSkyblue,    ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".lua",        clIndigo,     ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".zig",        clSkyblue,    ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".c",          clMDseagreen, ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".cpp",        clMDseagreen, ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".h",          clYellow,     ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".d",          clWhite2,     ICON_FA_FILE,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".txt",        clWhite2,     ICON_FA_FILE_LINES,     pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".TXT",        clWhite2,     ICON_FA_FILE_LINES,     pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".ini",        clWhite2,     ICON_FA_BAHAI,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".md",         clMoccasin,   ICON_FA_PEN_TO_SQUARE,  pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".html",       clMoccasin,   ICON_FA_GLOBE,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".gitignore",  clWhite2,     ICON_FA_BAHAI,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".gitmodules", clWhite2,     ICON_FA_BAHAI,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".o",          clWhite2,     ICON_FA_SEEDLING,       pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".a",          clWhite2,     ICON_FA_BAHAI,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".rc",         clWhite2,     ICON_FA_BAHAI,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".res",        clWhite2,     ICON_FA_BAHAI,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".ico",        clWhite,      ICON_FA_IMAGE,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".png",        clWhite,      ICON_FA_IMAGE,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".jpg",        clWhite,      ICON_FA_IMAGE,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".mp3",        clWhite,      ICON_FA_MUSIC,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".MP3",        clWhite,      ICON_FA_MUSIC,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".mp4",        clWhite,      ICON_FA_FILM,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".MP4",        clWhite,      ICON_FA_FILM,           pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".zip",        clWhite,      ICON_FA_FILE_ZIPPER,    pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".cmake",      clYellow,     ICON_FA_GEARS,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".mak",        clWhite,      ICON_FA_GEARS,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".mk",         clWhite,      ICON_FA_GEARS,          pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".dll",        clWhite,      ICON_FA_SNOWFLAKE,      pFont)
    ImGuiFileDialog.SetFileStyle(cfd, byExt, ".sys",        clWhite,      ICON_FA_SNOWMAN,        pFont)
    #-- For folder
    ImGuiFileDialog.SetFileStyle(cfd, ImGuiFileDialog::FileStyleByTypeDir, nil, clOrange, ICON_FA_FOLDER, pFont)
    #-- Regex TODO
    #--ImGuiFileDialog.SetFileStyle(cfd, byExt , "(.+[.].+)",   clWhite2,     ICON_FA_FILE,           pFont)
  end
end

App.new
