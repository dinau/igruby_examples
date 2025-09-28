
require 'fiddle'
require 'fiddle/import'

require_relative 'imgui_dll'

case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  module WinAPI
    extend Fiddle::Importer
   dlload 'kernel32.dll'
   extern 'void* GetModuleHandleA(const char*)'
   extern 'unsigned long GetModuleFileNameA(void*, char*, unsigned long)'
  end

  # Confirm dll state
  def get_imgui_dll_path()
    dll = ImGui_DLL.name                # from imgui_dll.rb
    puts "ImGui_DLL: [ #{ImGui_DLL.name} ]"
    hmod = WinAPI.GetModuleHandleA(dll)
    if hmod != 0
      buffer = "\0" * 2048
      WinAPI.GetModuleFileNameA(hmod, buffer, buffer.size)
      path = buffer.split("\0").first
      puts "#{dll}: Path: [ #{path} ]"
    else
      puts "Error!: #{dll} : hasn't loaded"
    end
    return path
  end
end
