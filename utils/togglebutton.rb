#--------------------------------------------------------
# This is very simple toggle button implementation from
#  https://github.com/sonoro1234/anima/blob/09901c69586bddd6d0463e8b7460eb251a1837e2/anima/igwidgets.lua#L6-L30
# Refer to
#  https://github.com/ocornut/imgui/issues/1537
#--------------------------------------------------------

# Converted in Ruby lang. by audin 2025/02.
#
require 'imgui'

#----------
# IM_COL32
#----------
def IM_COL32(a,b,c,d) #: ImU32  =
  return ImGui::GetColorU32(ImVec4.create(a/255.0, b/255.0, c/255.0, d/255.0))
end

module ImGui
  #--------------
  # ToggleButton     Custom widget
  #--------------
  def self.ToggleButton(str_id, pbVal)
    @baseColor    = 170
    @diffColor    = 30
    @hoveredColor = IM_COL32(@baseColor + @diffColor, @baseColor + @diffColor, @baseColor + @diffColor, 255)
    @normalColor  = IM_COL32(@baseColor, @baseColor, @baseColor, 255)
    @knobColor    = IM_COL32(0, 150, 200, 255)

    pos       = ImGui::GetCursorScreenPos()
    draw_list = ImGui::GetWindowDrawList()
    @height   = ImGui::GetFrameHeight() * 0.9
    width     = @height * 1.65
    radius    = @height * 0.50

    ret = false
    if ImGui::InvisibleButton(str_id, ImVec2.create(width, @height)) then
      pbVal.write(:bool, not pbVal.read(:bool))
      ret = true
    end
    col_bg   = 0
    col_base = 0 #: ImU32
    if ImGui::IsItemHovered() then
      col_base = @hoveredColor
      col_bg = col_base
      if pbVal.read(:bool) then
        col_bg = col_base or ImGui::GetColorU32(ImGuiCol_ButtonHovered, 1)
      end
    else
      col_base = @normalColor
      col_bg = col_base
      if pbVal.read(:bool) then
        col_bg = col_base or ImGui::GetColorU32(ImGuiCol_Button, 1)
      end
    end

    ImDrawList.new(draw_list).AddRectFilled(pos, ImVec2.create(pos[:x] + width, pos[:y] + @height), col_bg, @height * 0.5)
    mf = 0.0
    if pbVal.read(:bool) then
      mf = pos[:x] + width - radius
    else
      mf = pos[:x] + radius
    end
    ImDrawList.new(draw_list).AddCircleFilled(ImVec2.create(mf, pos[:y] + radius), radius - 1.5, @knobColor)
    ImGui::SameLine()
    ImGui::Text(str_id)
    return ret
  end
end
