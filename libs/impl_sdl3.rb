require 'ffi'
require 'opengl'

require_relative './dll_path'

module ImGui
  extend FFI::Library
  ffi_lib  get_imgui_dll_path()
  # --- SDL3 ---
  typedef :pointer, :SDL_Gamepad
  typedef :pointer, :SDL_Window
  typedef :pointer, :SDL_Renderer
  enum :ImplSDL3_GamepadMode, [:AutoFirst, :AutoAll, :Manual]
  attach_function :ImplSDL3_InitForOpenGL,      :ImGui_ImplSDL3_InitForOpenGL,      [:SDL_Window, :pointer], :bool
  attach_function :ImplSDL3_InitForVulkan,      :ImGui_ImplSDL3_InitForVulkan,      [:SDL_Window], :bool
  attach_function :ImplSDL3_InitForD3D,         :ImGui_ImplSDL3_InitForD3D,         [:SDL_Window], :bool
  attach_function :ImplSDL3_InitForMetal,       :ImGui_ImplSDL3_InitForMetal,       [:SDL_Window], :bool
  attach_function :ImplSDL3_InitForSDLRenderer, :ImGui_ImplSDL3_InitForSDLRenderer, [:SDL_Window, :SDL_Renderer], :bool
  attach_function :ImplSDL3_InitForSDLGPU,      :ImGui_ImplSDL3_InitForSDLGPU,      [:SDL_Window], :bool
  attach_function :ImplSDL3_InitForOther,       :ImGui_ImplSDL3_InitForOther,       [:SDL_Window], :bool
  attach_function :ImplSDL3_Shutdown,           :ImGui_ImplSDL3_Shutdown,           [], :void
  attach_function :ImplSDL3_NewFrame,           :ImGui_ImplSDL3_NewFrame,           [], :void
  attach_function :ImplSDL3_ProcessEvent,      :ImGui_ImplSDL3_ProcessEvent,        [:pointer], :bool
  attach_function :ImplSDL3_SetGamepadMode,    :ImGui_ImplSDL3_SetGamepadMode,      [:ImplSDL3_GamepadMode, :pointer, :int], :void
end
