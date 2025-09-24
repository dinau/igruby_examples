require_relative  __dir__  + '/fonticon/IconsFontAwesome6'
require 'imgui'

IconfontFullPath = File.join(__dir__ , 'fonticon','fa6','fa-solid-900.ttf')

#-----------
# point2px
#-----------
def point2px(point) ## Convert point to pixel
  return (point * 96) / 72.0
end

Config = ImFontConfig.create

case RUBY_PLATFORM
when /mswin|msys|mingw|cygwin/
  FontTable = [["meiryo.ttc",  "メイリオ",14.5],     # Windows7, 8
               ["YuGothM.ttc", "遊ゴシック M",11.0], # Windows10, 11
               ["meiryob.ttc", "メイリオ B",14.0],
               ["msgothic.ttc","MS ゴシック",11.0],
               ["myricam.ttc", "MyricaM",11.0],
               ["segoeui.ttf", "Seoge UI",14.4]      # English region standard font
             ]
when /linux/
  FontTable = [["opentype/ipafont-gothic/ipag.ttf","IPAゴシック",14.0],        # Debian
               ["opentype/ipafont-gothic/ipam.ttf","IPAゴシック M",14.0],      # Debian
               ["opentype/noto/NotoSansCJK-Regular.ttc","Noto Sans CJK",14.0], # Linux Mint
               ["truetype/liberation/LiberationMono-Regular.ttf","LiberationMono",13.0] # Ubuntu english
              ]
else
  raise RuntimeError, "setupFonts.rb : Unknown OS: #{RUBY_PLATFORM}"
end

#------------
# setupFonts
#------------
def setupFonts()
  main_font = nil
  pio = ImGuiIO.new(ImGui::GetIO())
  case RUBY_PLATFORM
  when /mswin|msys|mingw|cygwin/
    fontFolder = File.join(ENV['windir'] , 'fonts')
  when /linux/
    fontFolder = '/usr/share/fonts'
  end
  FontTable.each do |fontInfo|
    fontFullPath = File.join(fontFolder, fontInfo[0])
    if File.exist?(fontFullPath) then
      main_font = pio[:Fonts].AddFontFromFileTTF(fontFullPath, point2px(fontInfo[2]), Config, pio[:Fonts].GetGlyphRangesJapanese())
      if main_font != nil then
        puts "Loaded Base font: #{fontFullPath}"
        break
      end
    end
  end
  if main_font == nil
    pio[:Fonts].AddFontDefault()
    puts "------- Error!: Can't find available font \n"
  end
  Config[:MergeMode] = true
  ranges_icon_fonts = [ICON_MIN_FA,  ICON_MAX_FA, 0].pack("s3")
  if File.exist?(IconfontFullPath) then
    err = pio[:Fonts].AddFontFromFileTTF(IconfontFullPath, point2px(11), Config, ranges_icon_fonts)
    if err == nil then
      puts "------- Error! Load: #{IconfontFullPath}\n"
    else
      puts "Loaded Icon font: #{IconfontFullPath}"
    end
  else
    puts "Error!: Can't find Icon fonts: #{IconfontFullPath}"
  end
  return main_font
end
