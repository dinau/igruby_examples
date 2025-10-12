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


class FFIint
  def initialize(val)
    @value = FFI::MemoryPointer.new(:int)
    @value.write_int(val)
  end
  def addr()
    @value
  end
  def set(val)
    @value.write(:int, val)
  end
  def read()
    @value.read_int()
  end
end
