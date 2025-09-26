require 'ffi'

module ImToggle
  extend FFI::Library
  ffi_lib get_imgui_dll_path()

  # 定数
  Phi = 1.6180339887498948482045
  DiameterToRadiusRatio = 0.5
  AnimationDurationDisabled = 0.0
  AnimationDurationDefault = 0.1
  AnimationDurationMinimum = AnimationDurationDisabled
  FrameRoundingDefault = 1.0
  FrameRoundingMinimum = 0.0
  FrameRoundingMaximum = 1.0
  KnobRoundingDefault = 1.0
  KnobRoundingMinimum = 0.0
  KnobRoundingMaximum = 1.0
  WidthRatioDefault = Phi
  WidthRatioMinimum = 1.0
  WidthRatioMaximum = 10.0
  KnobInsetMinimum = -100.0
  KnobInsetMaximum = 100.0
  BorderThicknessDefault = 1.0
  ShadowThicknessDefault = 2.0
  LabelA11yOnDefault = '1'
  LabelA11yOffDefault = '0'

  # Enum
  module ImGuiToggleFlags
    None = 0 # 0
    Animated = 1 # 1 << 0
    BorderedFrame = 8 # 1 << 3
    BorderedKnob = 16 # 1 << 4
    ShadowedFrame = 32 # 1 << 5
    ShadowedKnob = 64 # 1 << 6
    A11y = 256 # 1 << 8
    Bordered = BorderedFrame | BorderedKnob # ImGuiToggleFlags_BorderedFrame | ImGuiToggleFlags_BorderedKnob
    Shadowed = ShadowedFrame | ShadowedKnob # ImGuiToggleFlags_ShadowedFrame | ImGuiToggleFlags_ShadowedKnob
    Default = None # ImGuiToggleFlags_None
  end

  enum :ImGuiToggleA11yStyle, [
    :Label, 0,
    :Glyph, 1,
    :Dot, 2,
    :Default, 0 # ImGuiToggleA11yStyle_Label
  ]

  class ImOffsetRect < FFI::Struct
    layout :left, :float,
           :right, :float,
           :top, :float,
           :bottom, :float
  end

  class ImGuiTogglePalette < FFI::Struct
    # opaque
  end

  class ImGuiToggleStateConfig < FFI::Struct
    layout :FrameBorderThickness, :float,
           :FrameShadowThickness, :float,
           :KnobBorderThickness, :float,
           :KnobShadowThickness, :float,
           :Label, :string,
           :KnobInset, ImOffsetRect,
           :KnobOffset, ImVec2,
           :Palette, :pointer # const ImGuiTogglePalette*
  end

  class ImGuiToggleConfig < FFI::Struct
    layout :Flags, :int, # ImGuiToggleFlags
           :A11yStyle, :ImGuiToggleA11yStyle,
           :AnimationDuration, :float,
           :FrameRounding, :float,
           :KnobRounding, :float,
           :WidthRatio, :float,
           :Size, ImVec2,
           :On, ImGuiToggleStateConfig,
           :Off, ImGuiToggleStateConfig
  end

  # 関数
  attach_function :Toggle, [:string, :pointer, ImVec2.by_value], :bool
  attach_function :ToggleFlag, [:string, :pointer, :int, ImVec2.by_value], :bool
  attach_function :ToggleAnim, [:string, :pointer, :int, :float, ImVec2.by_value], :bool
  attach_function :ToggleCfg, [:string, :pointer, ImGuiToggleConfig.by_value], :bool
  attach_function :ToggleRound, [:string, :pointer, :int, :float, :float, ImVec2.by_value], :bool
  attach_function :ToggleAnimRound, [:string, :pointer, :int, :float, :float, :float, ImVec2.by_value], :bool
end


module ImGui
  extend FFI::Library
  ffi_lib get_imgui_dll_path()

  enum :ImGuiToggleA11yStyle, [
    :Label, 0,
    :Glyph, 1,
    :Dot, 2,
    :Default, 0 # ImGuiToggleA11yStyle_Label
  ]

  # TODO
  #attach_function :TogglePresets_DefaultStyle,   :ImGuiTogglePresets_DefaultStyle, [], ImGuiToggleConfig
  #attach_function :TogglePresets_RectangleStyle, :ImGuiTogglePresets_RectangleStyle, [], ImGuiToggleConfig
  #attach_function :TogglePresets_GlowingStyle,   :ImGuiTogglePresets_GlowingStyle, [], ImGuiToggleConfig
  #attach_function :TogglePresets_iOSStyle,       :ImGuiTogglePresets_iOSStyle, [:float, :bool], ImGuiToggleConfig
  #attach_function :TogglePresets_MaterialStyle,  :ImGuiTogglePresets_MaterialStyle, [:float], ImGuiToggleConfig
  #attach_function :TogglePresets_MinecraftStyle, :ImGuiTogglePresets_MinecraftStyle, [:float], ImGuiToggleConfig
  #attach_function :ToggleConfig_init,            :ImGuiToggleConfig_init, [:pointer], :void
end
