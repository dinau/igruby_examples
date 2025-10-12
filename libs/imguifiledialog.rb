# frozen_string_literal: true
require 'ffi'

module ImGuiFileDialog
  extend FFI::Library

  ffi_lib get_imgui_dll_path()

  # --- libc free
  #module LibC
  #  extend FFI::Library
  #  ffi_lib FFI::Library::LIBC
  #  attach_function :free, [:pointer], :void
  #end

  VERSION = "v0.6.8"
  IMGUI_SUPPORTED_VERSION = "1.90.5 WIP"

  # IGFD_FileStyleFlags_
  FileStyle_None                 = 0
  FileStyleByTypeFile            = 1    # (1 << 0)
  FileStyleByTypeDir             = 2    # (1 << 1)
  FileStyleByTypeLink            = 4    # (1 << 2)
  FileStyleByExtention           = 8    # (1 << 3)
  FileStyleByFullName            = 16   # (1 << 4)
  FileStyleByContainedInFullName = 32   # (1 << 5)

  # ImGuiFileDialogFlags_
  ImGuiFileDialogFlags_None                              = 0
  ImGuiFileDialogFlags_ConfirmOverwrite                  = 1      # (1 << 0)
  ImGuiFileDialogFlags_DontShowHiddenFiles               = 2      # (1 << 1)
  ImGuiFileDialogFlags_DisableCreateDirectoryButton      = 4      # (1 << 2)
  ImGuiFileDialogFlags_HideColumnType                    = 8      # (1 << 3)
  ImGuiFileDialogFlags_HideColumnSize                    = 16     # (1 << 4)
  ImGuiFileDialogFlags_HideColumnDate                    = 32     # (1 << 5)
  ImGuiFileDialogFlags_NoDialog                          = 64     # (1 << 6)
  ImGuiFileDialogFlags_ReadOnlyFileNameField             = 128    # (1 << 7)
  ImGuiFileDialogFlags_CaseInsensitiveExtentionFiltering = 256    # (1 << 8)
  ImGuiFileDialogFlags_Modal                             = 512    # (1 << 9)
  ImGuiFileDialogFlags_DisableThumbnailMode              = 1024   # (1 << 10)
  ImGuiFileDialogFlags_DisablePlaceMode                  = 2048   # (1 << 11)
  ImGuiFileDialogFlags_DisableQuickPathSelection         = 4096   # (1 << 12)
  ImGuiFileDialogFlags_ShowDevicesButton                 = 8192   # (1 << 13)
  ImGuiFileDialogFlags_NaturalSorting                    = 16384  # (1 << 14)

  # ImGuiFileDialogFlags_Default = ConfirmOverwrite | Modal | HideColumnType
  ImGuiFileDialogFlags_Default = ImGuiFileDialogFlags_ConfirmOverwrite |
                                 ImGuiFileDialogFlags_Modal |
                                 ImGuiFileDialogFlags_HideColumnType

  # IGFD_ResultMode_
  ResultMode_AddIfNoFileExt      = 0  # default
  ResultMode_OverwriteFileExt    = 1  # behavior pre IGFD v0.6.6
  ResultMode_KeepInputFile       = 2

  if true
    class Thumbnail_Info < FFI::Struct
      layout :isReadyToDisplay, :int,    # =0
             :isReadyToUpload,  :int,    # =0
             :isLoadingOrLoaded, :int,   # =0
             :textureWidth,     :int,    # =0
             :textureHeight,    :int,    # =0
             :textureChannels,  :int,    # =0
             :textureFileDatas, :pointer,# unsigned char*
             :textureID,        :pointer,# void* (ImTextureID 等)
             :userDatas,        :pointer # void*
    end
  end

  class FileDialog_Config < FFI::Struct
    layout :path,              :pointer,
           :fileName,          :pointer,
           :filePathName,      :pointer,
           :countSelectionMax, :int32,
           :userDatas,         :pointer,
           :sidePane,          :pointer, # IGFD_PaneFun is a callback (const char*, void*, bool*)
           :sidePaneWidth,     :float,
           :flags,             :int # ImGuiFileDialogFlags
  end

  class Selection_Pair < FFI::Struct
    layout :fileName,     :pointer, # char*
           :filePathName, :pointer  # char*
  end

  class Selection < FFI::Struct
    layout :table, :pointer, # IGFD_Selection_Pair*
           :count, :ulong
  end

  # IGFD_FileDialog_Config_Get
  attach_function :IGFD_FileDialog_Config_Get, [], FileDialog_Config.by_value
  attach_function :FileDialog_Config_Get, :IGFD_FileDialog_Config_Get, [], FileDialog_Config.by_value

  # IGFD_Selection_Pair_Get / DestroyContent
  attach_function :IGFD_Selection_Pair_Get, [], Selection_Pair.by_value
  attach_function :Selection_Pair_Get, :IGFD_Selection_Pair_Get, [], Selection_Pair.by_value

  attach_function :IGFD_Selection_Pair_DestroyContent, [:pointer], :void
  attach_function :Selection_Pair_DestroyContent, :IGFD_Selection_Pair_DestroyContent, [:pointer], :void

  # IGFD_Selection_Get / DestroyContent
  attach_function :IGFD_Selection_Get, [], Selection.by_value
  attach_function :Selection_Get, :IGFD_Selection_Get, [], Selection.by_value

  attach_function :IGFD_Selection_DestroyContent, [:pointer], :void
  attach_function :Selection_DestroyContent, :IGFD_Selection_DestroyContent, [:pointer], :void

  # constructor / destructor
  attach_function :IGFD_Create, [], :pointer
  attach_function :Create, :IGFD_Create, [], :pointer

  attach_function :IGFD_Destroy, [:pointer], :void
  attach_function :Destroy, :IGFD_Destroy, [:pointer], :void

  # Thumbnail callbacks (USE_THUMBNAILS)
  attach_function :SetCreateThumbnailCallback, [:pointer, :pointer], :void # IGFD_CreateThumbnailFun -> pointer

  attach_function :SetDestroyThumbnailCallback, :SetDestroyThumbnailCallback, [:pointer, :pointer], :void

  attach_function :ManageGPUThumbnails, :ManageGPUThumbnails, [:pointer], :void

  # Open / Display / Close / IsOk
  attach_function :IGFD_OpenDialog, [:pointer, :string, :string, :string, FileDialog_Config.by_value], :void
  attach_function :OpenDialog, :IGFD_OpenDialog, [:pointer, :string, :string, :string, FileDialog_Config.by_value], :void

  # IGFD_DisplayDialog
  attach_function :IGFD_DisplayDialog, [:pointer, :string, :int,                 ImVec2.by_value, ImVec2.by_value], :bool
  attach_function :DisplayDialog, :IGFD_DisplayDialog, [:pointer, :string, :int, ImVec2.by_value, ImVec2.by_value], :bool

  attach_function :IGFD_CloseDialog, [:pointer], :void
  attach_function :CloseDialog, :IGFD_CloseDialog, [:pointer], :void

  attach_function :IGFD_IsOk, [:pointer], :bool
  attach_function :IsOk, :IGFD_IsOk, [:pointer], :bool

  attach_function :IGFD_WasKeyOpenedThisFrame, [:pointer, :string], :bool
  attach_function :WasKeyOpenedThisFrame, :IGFD_WasKeyOpenedThisFrame, [:pointer, :string], :bool

  attach_function :IGFD_WasOpenedThisFrame, [:pointer], :bool
  attach_function :WasOpenedThisFrame, :IGFD_WasOpenedThisFrame, [:pointer], :bool

  attach_function :IGFD_IsKeyOpened, [:pointer, :string], :bool
  attach_function :IsKeyOpened, :IGFD_IsKeyOpened, [:pointer, :string], :bool

  attach_function :IGFD_IsOpened, [:pointer], :bool
  attach_function :IsOpened, :IGFD_IsOpened, [:pointer], :bool

  # Selection / GetFilePathName / GetCurrentFileName / GetCurrentPath / GetCurrentFilter
  attach_function :IGFD_GetSelection, [:pointer, :int], Selection.by_value
  attach_function :GetSelection, :IGFD_GetSelection, [:pointer, :int], Selection.by_value

  attach_function :IGFD_GetFilePathName, [:pointer, :int], :pointer
  attach_function :GetFilePathName, :IGFD_GetFilePathName, [:pointer, :int], :pointer

  attach_function :IGFD_GetCurrentFileName, [:pointer, :int], :pointer
  attach_function :GetCurrentFileName, :IGFD_GetCurrentFileName, [:pointer, :int], :pointer

  attach_function :IGFD_GetCurrentPath, [:pointer], :pointer
  attach_function :GetCurrentPath, :IGFD_GetCurrentPath, [:pointer], :pointer

  attach_function :IGFD_GetCurrentFilter, [:pointer], :pointer
  attach_function :GetCurrentFilter, :IGFD_GetCurrentFilter, [:pointer], :pointer

  attach_function :IGFD_GetUserDatas, [:pointer], :pointer
  attach_function :GetUserDatas, :IGFD_GetUserDatas, [:pointer], :pointer

  # File style settings
  # IGFD_SetFileStyle (ImVec4 vColor, const char* vIconText, ImFont* vFont)
  attach_function :IGFD_SetFileStyle, [:pointer, :int, :string, :pointer, :string, :pointer], :void
  attach_function :SetFileStyle, :IGFD_SetFileStyle, [:pointer, :int, :string, :pointer, :string, :pointer], :void

  # IGFD_SetFileStyle2 with RGBA floats
  attach_function :IGFD_SetFileStyle2, [:pointer, :int, :string, :float, :float, :float, :float, :string, :pointer], :void
  attach_function :SetFileStyle2, :IGFD_SetFileStyle2, [:pointer, :int, :string, :float, :float, :float, :float, :string, :pointer], :void

  # IGFD_GetFileStyle returns bool and has out params: ImVec4* vOutColor, char** vOutIconText, ImFont** vOutFont
  attach_function :IGFD_GetFileStyle, [:pointer, :int, :string, :pointer, :pointer, :pointer], :bool
  attach_function :GetFileStyle, :IGFD_GetFileStyle, [:pointer, :int, :string, :pointer, :pointer, :pointer], :bool

  attach_function :IGFD_ClearFilesStyle, [:pointer], :void
  attach_function :ClearFilesStyle, :IGFD_ClearFilesStyle, [:pointer], :void

  # SetLocales
  attach_function :IGFD_SetLocales, :SetLocales, [:pointer, :int, :string, :string], :void

  # Flashing attenuation (USE_EXPLORATION_BY_KEYS)
  attach_function :IGFD_SetFlashingAttenuationInSeconds, [:pointer, :float], :void
  attach_function :SetFlashingAttenuationInSeconds, :IGFD_SetFlashingAttenuationInSeconds, [:pointer, :float], :void

  # Places feature
  attach_function :IGFD_SerializePlaces, [:pointer, :bool], :pointer
  attach_function :SerializePlaces, :IGFD_SerializePlaces, [:pointer, :bool], :pointer

  attach_function :IGFD_DeserializePlaces, [:pointer, :string], :void
  attach_function :DeserializePlaces, :IGFD_DeserializePlaces, [:pointer, :string], :void

  attach_function :IGFD_AddPlacesGroup, [:pointer, :string, :ulong, :bool], :bool
  attach_function :AddPlacesGroup, :IGFD_AddPlacesGroup, [:pointer, :string, :ulong, :bool], :bool

  attach_function :IGFD_RemovePlacesGroup, [:pointer, :string], :bool
  attach_function :RemovePlacesGroup, :IGFD_RemovePlacesGroup, [:pointer, :string], :bool

  attach_function :IGFD_AddPlace, [:pointer, :string, :string, :string, :bool, :string], :bool
  attach_function :AddPlace, :IGFD_AddPlace, [:pointer, :string, :string, :string, :bool, :string], :bool

  attach_function :IGFD_RemovePlace, [:pointer, :string, :string], :bool
  attach_function :RemovePlace, :IGFD_RemovePlace, [:pointer, :string, :string], :bool

  # Free memory
  attach_function :free, :freeMem, [:pointer], :void # See.  ../libc/tools.c
end
