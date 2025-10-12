require 'imgui'
require 'imgui_internal'
require 'rubygems'



case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  if false then
    #dll_path =  (Dir.pwd + '/dlls/imgui.dll').gsub('/','\\')
    puts "DLL path: " + ImGui_DLL.name
    ImGui.load_lib(ImGui_DLL.name)
  else
    dll = Gem.find_files(ImGui_DLL.name)[0].gsub('/','\\')
    ImGui.load_lib(dll)
  end
  ImGui.import_internal_symbols()
when /darwin/
  arch = RUBY_PLATFORM.split('-')[0]
  ImGui.load_lib(Dir.pwd + '/../lib/' + "imgui.#{arch}.dylib")
  ImGui.import_internal_symbols()
when /linux/
  arch = RUBY_PLATFORM.split('-')[0]
  #ImGui.load_lib(Dir.pwd + '/../lib/' + "imgui.#{arch}.so")
  ImGui_DLL.name = "imgui.so"
  dll = Gem.find_files(ImGui_DLL.name)[0]
  p Gem.find_files(ImGui_DLL.name)
  ImGui.load_lib(dll)
  #ImGui.load_lib(Dir.pwd + '/../lib/' + "imgui.so")
  ImGui.import_internal_symbols()
else
  raise RuntimeError, "setup_dll.rb : Unknown OS: #{RUBY_PLATFORM}"
end
