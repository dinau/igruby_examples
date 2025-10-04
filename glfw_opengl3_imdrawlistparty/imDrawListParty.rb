# Reference to
#   ImDrawList coding party - deadline Nov 30, 2020! #3606
#     https://github.com/ocornut/imgui/issues/3606

class ImVec2
  def add(b)
    ImVec2.create(self[:x] + b[:x], self[:y] + b[:y])
  end

  def sub(b)
    ImVec2.create(self[:x] - b[:x], self[:y] - b[:y])
  end

  def div(d)
    ImVec2.create(self[:x] / d, self[:y] / d)
  end
end

#// Function signature:
#//  void FX(ImDrawList* d, ImVec2 a, ImVec2 b, ImVec2 sz, ImVec4 mouse, float t);
#//     d : draw list
#//     a : upper-left corner
#//     b : lower-right corner
#//    sz : size (== b - a)
#// mouse : x,y = mouse position (normalized so 0,0 over 'a'; 1,1 is over 'b', not clamped)
#//         z,w = left/right button held. <-1.0f not pressed, 0.0f just pressed, >0.0f time held.
#//    t  : time
#// If not using a given parameter, you can omit its name in your function to save a few characters.

module ImGuiFX
  extend self

  # ImCol32
  def ImCol32(r, g, b, a = 0xff)
    ((a.to_i & 0xff) << 24) |
    ((b.to_i & 0xff) << 16) |
    ((g.to_i & 0xff) << 8)  |
    (r.to_i & 0xff)
  end

  #---------
  # fxCurve    This demo has been converted to Ruby from Curve (https://github.com/ocornut/imgui/issues/3606#issuecomment-730648517)
  #---------
  def fxCurve(d, a, b, sz, mouse, tx)
    t = tx
    while t < tx + 1.0
      t += 1.0 / 100.0
      cp0 = ImVec2.create(a[:x], b[:y])
      cp1 = ImVec2.create(b[:x], b[:y])

      ts = t - tx
      cp0[:x] += (0.4 + Math.sin(t) * 0.3) * sz[:x]
      cp0[:y] -= (0.5 + Math.cos(ts * ts) * 0.4) * sz[:y]
      cp1[:x] -= (0.4 + Math.cos(t) * 0.4) * sz[:x]
      cp1[:y] -= (0.5 + Math.sin(ts * t) * 0.3) * sz[:y]

      d.AddBezierCubic(
        ImVec2.create(a[:x], b[:y]), cp0, cp1, b,
        ImCol32(100 + ts*150, 255 - ts*150, 60, ts * 200),
        5.0
      )
    end
  end

  #----------
  # fxVisual    This demo has been converted to Ruby from Real-time visualization of the interweb blogosphere. (https://github.com/ocornut/imgui/issues/3606#issuecomment-730704909)
  #----------
  N = 300
  SD = 0x7fff
  @@v = Array.new(N) {
    rnd = ImVec2.create(rand(SD) % 320, rand(SD) % 180)
    { first: rnd, second: rnd }
  }

  def l2(x)
    x[:x] * x[:x] + x[:y] * x[:y]
  end

  def fxVisual(d, a, b, s, mouse, tx)
    @@v.each do |p|
      dval = Math.sqrt(l2(p[:first].sub(p[:second])))
      if dval > 0
        p[:first] = p[:first].add( (
                                    (p[:second].sub(p[:first])).div(dval)
                                   )
                                 )
      end
      if dval < 4
        p[:second] = ImVec2.create(rand(SD) % 320, rand(SD) % 180)
      end
    end

    (0...N).each do |i|
      j = i + 1
      while j < N
        dval = l2(@@v[i][:first].sub(@@v[j][:first]))
        t = l2((@@v[i][:first].add(@@v[j][:first])).sub(s)) / 200.0
        t = 255 if t > 255
        if dval < 400
          d.AddLine(
            a.add(@@v[i][:first]),
            a.add(@@v[j][:first]),
            ImCol32(t, 255 - t, 255, 70), 2
          )
        end
        j += 1
      end
    end
  end

  #----------------
  # fxTestBed
  #----------------
  def fxTestBed(title, showdemo, fx)
    io = ImGuiIO.new(ImGui::GetIO())
    ImGui::Begin(title, showdemo, ImGuiWindowFlags_AlwaysAutoResize)
    begin
      size = ImVec2.create(320.0, 180.0)
      ImGui::InvisibleButton("canvas", size)
      p0 = ImGui::GetItemRectMin()
      p1 = ImGui::GetItemRectMax()
      draw_list = ImDrawList.new(ImGui::GetWindowDrawList())

      draw_list.PushClipRect(p0, p1)
      begin
        mouse_data = ImVec4.create()
        mouse_data[:x] = (io[:MousePos][:x] - p0[:x]) / size[:x]
        mouse_data[:y] = (io[:MousePos][:y] - p0[:y]) / size[:y]
        mouse_data[:z] = io[:MouseDownDuration][0]
        mouse_data[:w] = io[:MouseDownDuration][1]

        fx.call(draw_list, p0, p1, size, mouse_data, ImGui::GetTime())
      ensure
        draw_list.PopClipRect()
      end
    ensure
      ImGui::End()
    end
  end
end
