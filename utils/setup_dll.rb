require'imgui'
require 'imgui_internal'
require 'rubygems'

local_dll = false

require 'imnodes'


case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  if false then
    #dll_path =  (Dir.pwd + '/dlls/imgui.dll').gsub('/','\\')
    dll_path =  'imgui.dll'
    puts "DLL path: " + dll_path
    ImGui.load_lib(dll_path)
  else
    dll = Gem.find_files('imgui.dll')[0].gsub('/','\\')
    ImGui.load_lib(dll)
  end
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
