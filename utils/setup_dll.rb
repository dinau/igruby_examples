require 'imgui'
require 'imgui_internal'
#require_relative '../glfw_opengl3_imnodes/imnodes'
require 'imnodes'

require 'rubygems'

case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  if true then
    ImGui.load_lib(Gem.find_files('imgui.dll'))
  else
    ImGui.load_lib(Dir.pwd + '/imgui.dll')
  end
  ImGui.import_internal_symbols()
  ImNodes.load_lib(Gem.find_files('imnodes.dll'))
  #ImNodes.load_lib(File.join(__dir__,'../glfw_opengl3_imnodes','imnodes.dll'),true)
when /darwin/
  arch = RUBY_PLATFORM.split('-')[0]
  ImGui.load_lib(Dir.pwd + '/../lib/' + "imgui.#{arch}.dylib")
  ImGui.import_internal_symbols()
  ImNodes.load_lib(Dir.pwd + '/../lib/' + "imnodes.#{arch}.dylib")
when /linux/
  arch = RUBY_PLATFORM.split('-')[0]
  ImGui.load_lib(Dir.pwd + '/../lib/' + "imgui.#{arch}.so")
  ImGui.import_internal_symbols()
  ImNodes.load_lib(Dir.pwd + '/../lib/' + "imnodes.#{arch}.so")
else
  raise RuntimeError, "setup_dll.rb : Unknown OS: #{RUBY_PLATFORM}"
end
