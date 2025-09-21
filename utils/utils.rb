require_relative './themeMicrosoft'

#---------------
#--- setTooltip
#---------------
def setTooltip(str, delay = ImGuiHoveredFlags_DelayNormal, color = ImVec4.create(0.0, 1.0, 0.0, 1.0))
  if ImGui::IsItemHovered(delay) then
    if ImGui::BeginTooltip() then
      ImGui::PushStyleColor(ImGuiCol_Text, color)
      ImGui::Text(str)
      ImGui::PopStyleColor(1)
      ImGui::EndTooltip()
    end
  end
end

#------------------------
#--- getRubyImguiVersion
#------------------------
def getRubyImGuiVersion
  # Find Imgui-Ruby version from Gem folders
  #sRubyImGuiVersion = Gem.find_files('imgui.dll') # very slow function
  #if sRubyImGuiVersion[0] =~ /\/(\w+\-\w+\-\d\.\d\.\d+)\-.+\// then
  #  sRubyImGuiVersion = $1
  #end
  #return sRubyImGuiVersion
  return "WIP"
end

module Theme
  Light = 0
  Dark  = 1
  Classic = 2
  Microsoft = 3

  @tbl = [ ["Light",     ->() {ImGui::StyleColorsLight()}   ],
           ["Dark",      ->() {ImGui::StyleColorsDark()}    ],
           ["Classic",   ->() {ImGui::StyleColorsClassic()} ],
           ["Microfoft", ->() {themeMicrosoft()}            ]
         ]

  #----------
  # setTheme
  #----------
  def setTheme(theme)
    @tbl[theme][1].call
    return @tbl[theme][0]
  end

  def getThemeString(theme)
    return @tbl[theme][0]
  end

  module_function :setTheme
  module_function :getThemeString
end
