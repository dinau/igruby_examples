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
  # GLFW
  attach_function :ImplGlfw_InitForOpenGL,     :ImGui_ImplGlfw_InitForOpenGL,     [:pointer, :bool], :bool
  attach_function :ImplGlfw_NewFrame,          :ImGui_ImplGlfw_NewFrame,          [],           :void
  attach_function :ImplGlfw_Shutdown,          :ImGui_ImplGlfw_Shutdown,          [],           :void
end


#require 'fiddle'
#
#module ImGui
#  #dll = Fiddle.dlopen('C:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\imgui-bindings-0.1.17-x64-mingw\lib\imgui.dll')
#  dll = Fiddle.dlopen('imgui.dll')
#
#  # 生の Fiddle::Function を作る
#  ImplGlfw_InitForOpenGL_fn = Fiddle::Function.new(
#    dll['ImGui_ImplGlfw_InitForOpenGL'],
#    [Fiddle::TYPE_VOIDP, Fiddle::TYPE_INT],
#    Fiddle::TYPE_INT
#  )
#
#  ImplGlfw_NewFrame_fn = Fiddle::Function.new(
#    dll['ImGui_ImplGlfw_NewFrame'],
#    [],
#    Fiddle::TYPE_VOID
#  )
#
#  ImplGlfw_Shutdown_fn = Fiddle::Function.new(
#    dll['ImGui_ImplGlfw_Shutdown'],
#    [],
#    Fiddle::TYPE_VOID
#  )
#
#  # メソッドとして呼べるラッパーを定義
#  def self.ImplGlfw_InitForOpenGL(window, install_callbacks)
#    ptr = window.nil? ? Fiddle::Pointer.new(0) : Fiddle::Pointer.new(window.to_i)
#    ImplGlfw_InitForOpenGL_fn.call(ptr, install_callbacks ? 1 : 0)
#  end
#
#  def self.ImplGlfw_NewFrame
#    ImplGlfw_NewFrame_fn.call
#  end
#
#  def self.ImplGlfw_Shutdown
#    ImplGlfw_Shutdown_fn.call
#  end
#end
