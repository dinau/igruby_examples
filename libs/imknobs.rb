# This file is handwritten (not auto-generated). :-)

require_relative './dll_path'

require 'ffi'

module ImGui
  extend FFI::Library
  ffi_lib get_imgui_dll_path()

  # ImGui-Knobs
  IgKnobFlags_NoTitle        = 1  # 1 << 0,
  IgKnobFlags_NoInput        = 2  # 1 << 1,
  IgKnobFlags_ValueTooltip   = 4  # 1 << 2,
  IgKnobFlags_DragHorizontal = 8  # 1 << 3,
  IgKnobFlags_DragVertical   = 16 # 1 << 4,

  IgKnobVariant_Tick         = 1  # 1 << 0,
  IgKnobVariant_Dot          = 2  # 1 << 1,
  IgKnobVariant_Wiper        = 4  # 1 << 2,
  IgKnobVariant_WiperOnly    = 8  # 1 << 3,
  IgKnobVariant_WiperDot     = 16 # 1 << 4,
  IgKnobVariant_Stepped      = 32 # 1 << 5,
  IgKnobVariant_Space        = 64 # 1 << 6,

  attach_function :IgKnobFloat, [:string,  # const char *label
                                 :pointer, # flaot *p_value
                                 :float,   # float v_min
                                 :float,   # float v_max
                                 :float,   # float speed = 0
                                 :string,  # const char *format = "%.3f"
                                 :int,     # IgKnobVariant vairnat == ImGuiKnobVariant_Tick
                                 :float,   # float size = 0
                                 :int,     # IgKnobsflags flags = 0
                                 :int,     # int steps = 10
                                 :float,   # flaot angle_min = -1
                                 :float],  # float angle_max = -1
                                 :bool

  attach_function :IgKnobInt  , [:string,  # const char *label
                                 :pointer, # int *p_value
                                 :int,     # int v_min
                                 :int,     # int v_max
                                 :float,   # float speed = 0
                                 :string,  # const char *format = "%i"
                                 :int,     # IgKnobVariant varriant = ImGuiKnobVariant_Tick
                                 :float,   # float size  = 0
                                 :int,     # IgKnobFlags flags = 0
                                 :int,     # int steps = 10
                                 :float,   # float angle_min = -1
                                 :float],  # float angle_max = -1
                                 :bool

  def self.Knob(str, pfloat_value, fv_min, fv_max)
    IgKnobFloat(str, pfloat_value, fv_min, fv_max, 0, "%.3f", self.ImGuiKnobVariant_Tick, 0, 0, 10, -1, -1)
  end

  def self.KnobEx(str, pfloat_value, fv_min, fv_max, speed, pFormat, variant, fsize, flags, steps, angle_min, angle_max)
    IgKnobFloat(str, pfloat_value, fv_min, fv_max, speed, pFormat, variant, fsize, flags, steps, angle_min, angle_max)
  end

  def self.KnobInt(str, pfloat_value, fv_min, fv_max)
    IgKnobFloat(str, pfloat_value, fv_min, fv_max, 0, "%i", ImGui::IgKnobVariant_Tick, 0, 0, 10, -1, -1)
  end

  def self.KnobIntEx(str, pint_value, fv_min, fv_max, speed, pFormat, variant, fsize, flags, steps, angle_min, angle_max)
    IgKnobFloat(str, pint_value, fv_min, fv_max, speed, pFormat, variant, fsize, flags, steps, angle_min, angle_max)
  end

end
