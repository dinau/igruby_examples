require 'ffi'
require 'opengl'

require_relative './dll_path'

module ImGui
  extend FFI::Library
  ffi_lib  get_imgui_dll_path()
  # --- OpenGL3 ---
  attach_function :ImplOpenGL3_Init,                 :ImGui_ImplOpenGL3_Init, [:string], :bool
  attach_function :ImplOpenGL3_Shutdown,             :ImGui_ImplOpenGL3_Shutdown, [], :void
  attach_function :ImplOpenGL3_NewFrame,             :ImGui_ImplOpenGL3_NewFrame, [], :void
  attach_function :ImplOpenGL3_RenderDrawData,       :ImGui_ImplOpenGL3_RenderDrawData, [:pointer], :void
  attach_function :ImplOpenGL3_CreateFontsTexture,   :ImGui_ImplOpenGL3_CreateFontsTexture, [], :bool
  attach_function :ImplOpenGL3_DestroyFontsTexture,  :ImGui_ImplOpenGL3_DestroyFontsTexture, [], :void
  attach_function :ImplOpenGL3_CreateDeviceObjects,  :ImGui_ImplOpenGL3_CreateDeviceObjects, [], :bool
  attach_function :ImplOpenGL3_DestroyDeviceObjects, :ImGui_ImplOpenGL3_DestroyDeviceObjects, [], :void
end
