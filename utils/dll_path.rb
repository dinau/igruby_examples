
require 'fiddle'
require 'fiddle/import'

module WinAPI
  extend Fiddle::Importer
 dlload 'kernel32.dll'
  extern 'void* GetModuleHandleA(const char*)'
  extern 'unsigned long GetModuleFileNameA(void*, char*, unsigned long)'
end

def get_imgui_dll_path()
  # imgui.dll がロードされているか確認
  hmod = WinAPI.GetModuleHandleA('imgui.dll')
  if hmod != 0
    buffer = "\0" * 2048
    WinAPI.GetModuleFileNameA(hmod, buffer, buffer.size)
    path = buffer.split("\0").first
    puts "imgui.dll path: #{path}"
  else
    puts "imgui.dll はロードされていません"
  end
  return path
end
