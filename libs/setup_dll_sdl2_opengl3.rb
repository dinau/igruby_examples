require'imgui'
require 'imgui_internal'
require 'rubygems'

local_dll = false

require 'imnodes'

require_relative 'imgui_dll'

case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  dll_path =  'imgui_sdl2_opengl3.dll'
  if false then
    #dll_path =  (Dir.pwd + '/dlls/imgui.dll').gsub('/','\\')
    ImGui_DLL.name = dll_path
    ImGui.load_lib(dll_path)
  else
    dll = Gem.find_files(dll_path)[0].gsub('/','\\')
    ImGui.load_lib(dll)
  end
  puts "DLL path: " + dll_path
  ImGui.import_internal_symbols()
  #ImNodes.load_lib(Gem.find_files('imnodes.dll'))
when /darwin/
  arch = RUBY_PLATFORM.split('-')[0]
  ImGui.load_lib(Dir.pwd + '/../lib/' + "imgui.#{arch}.dylib")
  ImGui.import_internal_symbols()
  ImNodes.load_lib(Dir.pwd + '/../lib/' + "imnodes.#{arch}.dylib")
when /linux/
  arch = RUBY_PLATFORM.split('-')[0]
  ImGui.load_lib(Dir.pwd + '/../lib/' + "imgui.#{arch}.so")
  ImGui.import_internal_symbols()
  #ImNodes.load_lib(Dir.pwd + '/../lib/' + "imnodes.#{arch}.so")
else
  raise RuntimeError, "setup_dll.rb : Unknown OS: #{RUBY_PLATFORM}"
end
