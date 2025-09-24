# typedef struct GLFWwindow GLFWwindow;
# typedef struct GLFWmonitor GLFWmonitor;
# struct GLFWwindow;
# struct GLFWmonitor;
# CIMGUI_API bool ImGui_ImplGlfw_InitForOpenGL(GLFWwindow* window,bool install_callbacks);
# CIMGUI_API bool ImGui_ImplGlfw_InitForVulkan(GLFWwindow* window,bool install_callbacks);
# CIMGUI_API bool ImGui_ImplGlfw_InitForOther(GLFWwindow* window,bool install_callbacks);
# CIMGUI_API void ImGui_ImplGlfw_Shutdown(void);
# CIMGUI_API void ImGui_ImplGlfw_NewFrame(void);
# CIMGUI_API void ImGui_ImplGlfw_InstallCallbacks(GLFWwindow* window);
# CIMGUI_API void ImGui_ImplGlfw_RestoreCallbacks(GLFWwindow* window);
# CIMGUI_API void ImGui_ImplGlfw_SetCallbacksChainForAllWindows(bool chain_for_all_windows);
# CIMGUI_API void ImGui_ImplGlfw_WindowFocusCallback(GLFWwindow* window,int focused);
# CIMGUI_API void ImGui_ImplGlfw_CursorEnterCallback(GLFWwindow* window,int entered);
# CIMGUI_API void ImGui_ImplGlfw_CursorPosCallback(GLFWwindow* window,double x,double y);
# CIMGUI_API void ImGui_ImplGlfw_MouseButtonCallback(GLFWwindow* window,int button,int action,int mods);
# CIMGUI_API void ImGui_ImplGlfw_ScrollCallback(GLFWwindow* window,double xoffset,double yoffset);
# CIMGUI_API void ImGui_ImplGlfw_KeyCallback(GLFWwindow* window,int key,int scancode,int action,int mods);
# CIMGUI_API void ImGui_ImplGlfw_CharCallback(GLFWwindow* window,unsigned int c);
# CIMGUI_API void ImGui_ImplGlfw_MonitorCallback(GLFWmonitor* monitor,int event);
# CIMGUI_API void ImGui_ImplGlfw_Sleep(int milliseconds);
#

require 'ffi'
require 'opengl'
require 'glfw'

require 'fiddle'
require 'fiddle/import'

require_relative './dll_path'

module ImGui
  extend FFI::Library
  #ffi_lib 'C:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\imgui-bindings-0.1.17-x64-mingw\lib\imgui.dll'
  ffi_lib get_imgui_dll_path()
  # --- GLFW ---
  typedef :pointer, :GLFWwindow
  typedef :pointer, :GLFWmonitor

  attach_function :ImplGlfw_InitForOpenGL,  :ImGui_ImplGlfw_InitForOpenGL,  [:GLFWwindow, :bool], :bool
  attach_function :ImplGlfw_InitForVulkan, :ImGui_ImplGlfw_InitForVulkan, [:GLFWwindow, :bool], :bool
  attach_function :ImplGlfw_InitForOther,  :ImGui_ImplGlfw_InitForOther,  [:GLFWwindow, :bool], :bool
  attach_function :ImplGlfw_Shutdown,      :ImGui_ImplGlfw_Shutdown,      [], :void
  attach_function :ImplGlfw_NewFrame,      :ImGui_ImplGlfw_NewFrame,      [], :void
  attach_function :ImplGlfw_InstallCallbacks, :ImGui_ImplGlfw_InstallCallbacks, [:GLFWwindow], :void
  attach_function :ImplGlfw_RestoreCallbacks, :ImGui_ImplGlfw_RestoreCallbacks, [:GLFWwindow], :void
  attach_function :ImplGlfw_SetCallbacksChainForAllWindows, :ImGui_ImplGlfw_SetCallbacksChainForAllWindows, [:bool], :void
  attach_function :ImplGlfw_WindowFocusCallback, :ImGui_ImplGlfw_WindowFocusCallback, [:GLFWwindow, :int], :void
  attach_function :ImplGlfw_CursorEnterCallback, :ImGui_ImplGlfw_CursorEnterCallback, [:GLFWwindow, :int], :void
  attach_function :ImplGlfw_CursorPosCallback,   :ImGui_ImplGlfw_CursorPosCallback,   [:GLFWwindow, :double, :double], :void
  attach_function :ImplGlfw_MouseButtonCallback, :ImGui_ImplGlfw_MouseButtonCallback, [:GLFWwindow, :int, :int, :int], :void
  attach_function :ImplGlfw_ScrollCallback,      :ImGui_ImplGlfw_ScrollCallback,      [:GLFWwindow, :double, :double], :void
  attach_function :ImplGlfw_KeyCallback,         :ImGui_ImplGlfw_KeyCallback,         [:GLFWwindow, :int, :int, :int, :int], :void
  attach_function :ImplGlfw_CharCallback,        :ImGui_ImplGlfw_CharCallback,        [:GLFWwindow, :uint], :void
  attach_function :ImplGlfw_MonitorCallback,     :ImGui_ImplGlfw_MonitorCallback,     [:GLFWmonitor, :int], :void
  attach_function :ImplGlfw_Sleep,               :ImGui_ImplGlfw_Sleep,               [:int], :void
end
