require_relative '../utils/dll_path'

require 'ffi'
module ImGui
 extend FFI::Library
 ffi_lib get_imgui_dll_path()
 attach_function :SpinnerDnaDots,   [:pointer, :float , :float ], :void
 attach_function :SpinnerDnaDotsEx, [:pointer, :float , :float, :pointer, :float, :int, :float, :bool ], :void
 attach_function :SpinnerAng8,      [:pointer, :float , :float ], :void
 attach_function :SpinnerFadeTris,  [:pointer, :float ], :void
 attach_function :SpinnerPulsar,    [:pointer, :float , :float ], :void
 attach_function :SpinnerClock,     [:pointer, :float , :float ], :void
 attach_function :SpinnerAtom,      [:pointer, :float , :float ], :void
 attach_function :SpinnerSwingDots, [:pointer, :float , :float ], :void
 attach_function :SpinnerDotsToBar, [:pointer, :float , :float, :float ], :void
 attach_function :SpinnerBarChartRainbow, [:pointer, :float, :float, :pointer, :float], :void
 attach_function :demoSpinners,[], :void
end
