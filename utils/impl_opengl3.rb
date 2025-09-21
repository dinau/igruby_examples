# CIMGUI_API bool ImGui_ImplOpenGL3_Init(const char* glsl_version);
# CIMGUI_API void ImGui_ImplOpenGL3_Shutdown(void);
# CIMGUI_API void ImGui_ImplOpenGL3_NewFrame(void);
# CIMGUI_API void ImGui_ImplOpenGL3_RenderDrawData(ImDrawData* draw_data);
# CIMGUI_API bool ImGui_ImplOpenGL3_CreateFontsTexture(void);
# CIMGUI_API void ImGui_ImplOpenGL3_DestroyFontsTexture(void);
# CIMGUI_API bool ImGui_ImplOpenGL3_CreateDeviceObjects(void);
# CIMGUI_API void ImGui_ImplOpenGL3_DestroyDeviceObjects(void);

require 'ffi'
require 'opengl'

require_relative './dll_path'

module ImGui
  extend FFI::Library
  #ffi_lib 'C:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\imgui-bindings-0.1.17-x64-mingw\lib\imgui.dll'
  ffi_lib  get_imgui_dll_path()
  # OpenGL3
  attach_function :ImplOpenGL3_Init,           :ImGui_ImplOpenGL3_Init,           [:pointer],   :bool
  attach_function :ImplOpenGL3_Shutdown,       :ImGui_ImplOpenGL3_Shutdown,       [],           :void
  attach_function :ImplOpenGL3_RenderDrawData, :ImGui_ImplOpenGL3_RenderDrawData, [:pointer],   :void
  attach_function :ImplOpenGL3_NewFrame,       :ImGui_ImplOpenGL3_NewFrame,       [],           :void
end



#require 'fiddle'
#
#module ImGui
#  #dll = Fiddle.dlopen('C:\Ruby34-x64\lib\ruby\gems\3.4.0\gems\imgui-bindings-0.1.17-x64-mingw\lib\imgui.dll')
#  dll = Fiddle.dlopen('imgui.dll')
#
#  # 生の Fiddle::Function を作成
#  ImplOpenGL3_Init_fn = Fiddle::Function.new(
#    dll['ImGui_ImplOpenGL3_Init'],
#    [Fiddle::TYPE_VOIDP],  # :pointer
#    Fiddle::TYPE_INT        # :bool
#  )
#
#  ImplOpenGL3_Shutdown_fn = Fiddle::Function.new(
#    dll['ImGui_ImplOpenGL3_Shutdown'],
#    [],
#    Fiddle::TYPE_VOID
#  )
#
#  ImplOpenGL3_RenderDrawData_fn = Fiddle::Function.new(
#    dll['ImGui_ImplOpenGL3_RenderDrawData'],
#    [Fiddle::TYPE_VOIDP],  # :pointer
#    Fiddle::TYPE_VOID
#  )
#
#  ImplOpenGL3_NewFrame_fn = Fiddle::Function.new(
#    dll['ImGui_ImplOpenGL3_NewFrame'],
#    [],
#    Fiddle::TYPE_VOID
#  )
#
#  # 呼び出し側用のメソッドラッパー
#  def self.ImplOpenGL3_Init(ctx)
#    ptr = ctx.nil? ? Fiddle::Pointer.new(0) : Fiddle::Pointer.new(ctx.to_i)
#    ImplOpenGL3_Init_fn.call(ptr)
#  end
#
#  def self.ImplOpenGL3_Shutdown
#    ImplOpenGL3_Shutdown_fn.call
#  end
#
#  def self.ImplOpenGL3_RenderDrawData(draw_data)
#    # draw_data が nil の場合でも Fiddle::Pointer.new(0) で安全
#    ptr = draw_data.nil? ? Fiddle::Pointer.new(0) : Fiddle::Pointer.new(draw_data.to_i)
#    ImplOpenGL3_RenderDrawData_fn.call(ptr)
#  end
#
#  def self.ImplOpenGL3_NewFrame
#    ImplOpenGL3_NewFrame_fn.call
#  end
#end
