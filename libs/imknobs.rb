require_relative '../utils/dll_path'

require 'ffi'

module ImGui
 extend FFI::Library
 ffi_lib get_imgui_dll_path()
 # ImGui-Knobs
 IgKnobFlags_NoTitle = 1        # 1 << 0,
 IgKnobFlags_NoInput = 2        # 1 << 1,
 IgKnobFlags_ValueTooltip = 4   # 1 << 2,
 IgKnobFlags_DragHorizontal = 8 # 1 << 3,
 IgKnobFlags_DragVertical = 16  # 1 << 4,

 IgKnobVariant_Tick = 1         # 1 << 0,
 IgKnobVariant_Dot = 2          # 1 << 1,
 IgKnobVariant_Wiper = 4        # 1 << 2,
 IgKnobVariant_WiperOnly = 8    # 1 << 3,
 IgKnobVariant_WiperDot = 16    # 1 << 4,
 IgKnobVariant_Stepped = 32     # 1 << 5,
 IgKnobVariant_Space = 64       # 1 << 6,
 attach_function :IgKnobFloat, [ :pointer,  # const char *label
                                 :pointer,  # flaot *p_value
                                 :float,    # float v_min
                                 :float,    # float v_max
                                 :float,    # float speed
                                 :pointer,  # const char *format
                                 :int,      # IgKnobVariant vairnat == int
                                 :float,    # float size
                                 :int,      # IgKnobsflags flags == int
                                 :int,      # int steps
                                 :float,    # flaot angle_min
                                 :float],   # float angle_max
                                 :bool
 attach_function :IgKnobInt  , [:pointer, :pointer, :int,   :int,   :float, :pointer, :int,     :float, :int,   :int, :float, :float], :bool
end
