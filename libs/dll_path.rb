
require 'fiddle'
require 'fiddle/import'

require_relative 'imgui_dll'

module WinAPI
  extend Fiddle::Importer
 dlload 'kernel32.dll'
  extern 'void* GetModuleHandleA(const char*)'
  extern 'unsigned long GetModuleFileNameA(void*, char*, unsigned long)'
end

def get_imgui_dll_path()
  # dll がロードされているか確認
  dll = ImGui_DLL.name                # from imgui_dll.rb
  puts "ImGui_DLL: [ #{ImGui_DLL.name} ]"
  hmod = WinAPI.GetModuleHandleA(dll)
  if hmod != 0
    buffer = "\0" * 2048
    WinAPI.GetModuleFileNameA(hmod, buffer, buffer.size)
    path = buffer.split("\0").first
    puts "#{dll}: Path: [ #{path} ]"
  else
    puts "#{dll} はロードされていません"
  end
  return path
end
