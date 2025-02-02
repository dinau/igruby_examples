# 2025/02 by audin

#--------------
#--- zoomGlass
#--------------
def zoomGlass(textureID, itemWidth, itemHeight, itemPosTop)
  # itemPosTop : absolute position in main window.
  if ImGui::BeginItemTooltip() then
    my_tex_w = itemWidth
    my_tex_h = itemHeight
    pio = ImGuiIO.new(ImGui::GetIO())
    region_sz = 32.0
    region_x = pio[:MousePos][:x] - itemPosTop[:x] - region_sz * 0.5
    region_y = pio[:MousePos][:y] - itemPosTop[:y] - region_sz * 0.5
    zoom = 4.0
    if region_x < 0.0 then
      region_x = 0.0
    elsif region_x > (my_tex_w - region_sz) then
      region_x = my_tex_w - region_sz
    end
    if region_y < 0.0 then
      region_y = 0.0
    elsif region_y > my_tex_h - region_sz then
      region_y = my_tex_h - region_sz
    end
    #
    uv0 = ImVec2.create((region_x) / my_tex_w, (region_y) / my_tex_h)
    uv1 = ImVec2.create((region_x + region_sz) / my_tex_w, (region_y + region_sz) / my_tex_h)
    tint_col   = ImVec4.create(1.0, 1.0, 1.0, 1.0)    # No tint
    border_col = ImVec4.create(0.22, 0.56, 0.22, 1.0) # Green
    ImGui::Image(textureID, ImVec2.create(region_sz * zoom, region_sz * zoom), uv0, uv1, tint_col, border_col)
    #
    ImGui::EndTooltip()
  end
end
