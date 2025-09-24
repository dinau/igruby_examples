require 'ffi'
require 'opengl'

require_relative './dll_path'

module ImGui
  extend FFI::Library
  ffi_lib  get_imgui_dll_path()
  # --- SDL2 ---
  typedef :pointer, :SDL_Window
  typedef :pointer, :SDL_Renderer
  typedef :pointer, :SDL_GameController
  typedef :pointer, :SDL_Event
  enum :ImplSDL2_GamepadMode, [:AutoFirst, :AutoAll, :Manual]

  attach_function :ImplSDL2_InitForOpenGL,      :ImGui_ImplSDL2_InitForOpenGL,      [:SDL_Window, :pointer], :bool
  attach_function :ImplSDL2_InitForVulkan,     :ImGui_ImplSDL2_InitForVulkan,     [:SDL_Window], :bool
  attach_function :ImplSDL2_InitForD3D,        :ImGui_ImplSDL2_InitForD3D,        [:SDL_Window], :bool
  attach_function :ImplSDL2_InitForMetal,      :ImGui_ImplSDL2_InitForMetal,      [:SDL_Window], :bool
  attach_function :ImplSDL2_InitForSDLRenderer,:ImGui_ImplSDL2_InitForSDLRenderer,[:SDL_Window, :SDL_Renderer], :bool
  attach_function :ImplSDL2_InitForOther,      :ImGui_ImplSDL2_InitForOther,      [:SDL_Window], :bool
  attach_function :ImplSDL2_Shutdown,          :ImGui_ImplSDL2_Shutdown,          [], :void
  attach_function :ImplSDL2_NewFrame,          :ImGui_ImplSDL2_NewFrame,          [], :void
  attach_function :ImplSDL2_ProcessEvent,      :ImGui_ImplSDL2_ProcessEvent,      [:pointer], :bool
  attach_function :ImplSDL2_SetGamepadMode,    :ImGui_ImplSDL2_SetGamepadMode,    [:ImplSDL2_GamepadMode, :pointer, :int], :void
end
