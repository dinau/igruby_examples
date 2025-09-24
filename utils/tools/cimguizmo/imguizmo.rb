# imguizmo_ffi.rb
# Generated from ImGuizmo.h — bitwise expressions replaced by computed integers;
# original expressions kept as comments for reference.

require 'ffi'

module ImGuizmo
  extend FFI::Library

  # adjust the library list/path to your environment as needed
  ffi_lib ['cimguizmo', 'ImGuizmo', 'imguizmo', 'imguizmo.dll', './imguizmo.dll']

  #
  # === OPERATION bits (computed values) ===
  #
  TRANSLATE_X = 1    # (1u << 0)
  TRANSLATE_Y = 2    # (1u << 1)
  TRANSLATE_Z = 4    # (1u << 2)
  ROTATE_X    = 8    # (1u << 3)
  ROTATE_Y    = 16   # (1u << 4)
  ROTATE_Z    = 32   # (1u << 5)
  ROTATE_SCREEN = 64 # (1u << 6)
  SCALE_X     = 128  # (1u << 7)
  SCALE_Y     = 256  # (1u << 8)
  SCALE_Z     = 512  # (1u << 9)
  BOUNDS      = 1024 # (1u << 10)
  SCALE_XU    = 2048 # (1u << 11)
  SCALE_YU    = 4096 # (1u << 12)
  SCALE_ZU    = 8192 # (1u << 13)

  # composite constants (computed)
  TRANSLATE = 7      # TRANSLATE_X | TRANSLATE_Y | TRANSLATE_Z  => (1|2|4) = 7
  ROTATE    = 120    # ROTATE_X | ROTATE_Y | ROTATE_Z | ROTATE_SCREEN => (8|16|32|64) = 120
  SCALE     = 896    # SCALE_X | SCALE_Y | SCALE_Z => (128|256|512) = 896
  SCALEU    = 14336  # SCALE_XU | SCALE_YU | SCALE_ZU => (2048|4096|8192) = 14336
  UNIVERSAL = 14463  # TRANSLATE | ROTATE | SCALEU => 7 | 120 | 14336 = 14463

  # Provide an FFI enum mapping too (uses computed values above)
  OPERATION = enum(
    :TRANSLATE_X, TRANSLATE_X,
    :TRANSLATE_Y, TRANSLATE_Y,
    :TRANSLATE_Z, TRANSLATE_Z,
    :ROTATE_X, ROTATE_X,
    :ROTATE_Y, ROTATE_Y,
    :ROTATE_Z, ROTATE_Z,
    :ROTATE_SCREEN, ROTATE_SCREEN,
    :SCALE_X, SCALE_X,
    :SCALE_Y, SCALE_Y,
    :SCALE_Z, SCALE_Z,
    :BOUNDS, BOUNDS,
    :SCALE_XU, SCALE_XU,
    :SCALE_YU, SCALE_YU,
    :SCALE_ZU, SCALE_ZU,
    # note: composites are defined above as constants
  )

  #
  # === MODE enum ===
  #
  MODE = enum(:LOCAL, 0, :WORLD, 1)

  #
  # === COLOR enum (explicit numeric mapping) ===
  #
  DIRECTION_X = 0
  DIRECTION_Y = 1
  DIRECTION_Z = 2
  PLANE_X     = 3
  PLANE_Y     = 4
  PLANE_Z     = 5
  SELECTION   = 6
  INACTIVE    = 7
  TRANSLATION_LINE = 8
  SCALE_LINE  = 9
  ROTATION_USING_BORDER = 10
  ROTATION_USING_FILL   = 11
  HATCHED_AXIS_LINES = 12
  TEXT        = 13
  TEXT_SHADOW = 14
  COUNT       = 15

  COLOR = enum(
    :DIRECTION_X, DIRECTION_X,
    :DIRECTION_Y, DIRECTION_Y,
    :DIRECTION_Z, DIRECTION_Z,
    :PLANE_X, PLANE_X,
    :PLANE_Y, PLANE_Y,
    :PLANE_Z, PLANE_Z,
    :SELECTION, SELECTION,
    :INACTIVE, INACTIVE,
    :TRANSLATION_LINE, TRANSLATION_LINE,
    :SCALE_LINE, SCALE_LINE,
    :ROTATION_USING_BORDER, ROTATION_USING_BORDER,
    :ROTATION_USING_FILL, ROTATION_USING_FILL,
    :HATCHED_AXIS_LINES, HATCHED_AXIS_LINES,
    :TEXT, TEXT,
    :TEXT_SHADOW, TEXT_SHADOW,
    :COUNT, COUNT
  )

  COLOR_COUNT = COUNT

  #
  # === Structs ===
  #
  class ImVec2 < FFI::Struct
    layout(
      :x, :float,
      :y, :float
    )
  end

  class ImVec4 < FFI::Struct
    layout(
      :x, :float,
      :y, :float,
      :z, :float,
      :w, :float
    )
  end

  class Style < FFI::Struct
    layout(
      :TranslationLineThickness, :float,
      :TranslationLineArrowSize, :float,
      :RotationLineThickness, :float,
      :RotationOuterLineThickness, :float,
      :ScaleLineThickness, :float,
      :ScaleLineCircleSize, :float,
      :HatchedAxisLineThickness, :float,
      :CenterCircleSize, :float,
      :Colors, [ImVec4, COLOR_COUNT]
    )
  end

  #
  # helper to wrap pointer -> Style instance
  #
  def self.style_from_ptr(ptr)
    return nil if ptr.nil? || ptr.null?
    Style.new(ptr)
  end

  #
  # === Functions (attach_function) ===
  #
  attach_function :ImGuizmo_SetDrawlist, [:pointer], :void
  attach_function :ImGuizmo_BeginFrame, [], :void
  attach_function :ImGuizmo_SetImGuiContext, [:pointer], :void
  attach_function :ImGuizmo_IsOver_Nil, [], :bool
  attach_function :ImGuizmo_IsUsing, [], :bool
  attach_function :ImGuizmo_IsUsingViewManipulate, [], :bool
  attach_function :ImGuizmo_IsViewManipulateHovered, [], :bool
  attach_function :ImGuizmo_IsUsingAny, [], :bool
  attach_function :ImGuizmo_Enable, [:bool], :void

  attach_function :ImGuizmo_DecomposeMatrixToComponents, [:pointer, :pointer, :pointer, :pointer], :void
  attach_function :ImGuizmo_RecomposeMatrixFromComponents, [:pointer, :pointer, :pointer, :pointer], :void

  attach_function :ImGuizmo_SetRect, [:float, :float, :float, :float], :void
  attach_function :ImGuizmo_SetOrthographic, [:bool], :void

  attach_function :ImGuizmo_DrawCubes, [:pointer, :pointer, :pointer, :int], :void
  attach_function :ImGuizmo_DrawGrid, [:pointer, :pointer, :pointer, :float], :void

  # Manipulate(const float* view,const float* projection, OPERATION operation, MODE mode, float* matrix, float* deltaMatrix, const float* snap, const float* localBounds, const float* boundsSnap)
  # we pass enums as unsigned ints (:uint)
  attach_function :ImGuizmo_Manipulate,
                  [:pointer, :pointer, :uint, :uint, :pointer, :pointer, :pointer, :pointer, :pointer],
                  :bool

  attach_function :ImGuizmo_ViewManipulate_Float, [:pointer, :float, ImVec2.by_value, ImVec2.by_value, :uint], :void

  attach_function :ImGuizmo_ViewManipulate_FloatPtr,
                  [:pointer, :pointer, :uint, :uint, :pointer, :float, ImVec2.by_value, ImVec2.by_value, :uint],
                  :void

  attach_function :ImGuizmo_SetAlternativeWindow, [:pointer], :void
  attach_function :ImGuizmo_SetID, [:int], :void
  attach_function :ImGuizmo_PushID_Str, [:string], :void
  attach_function :ImGuizmo_PushID_StrStr, [:string, :string], :void
  attach_function :ImGuizmo_PushID_Ptr, [:pointer], :void
  attach_function :ImGuizmo_PushID_Int, [:int], :void
  attach_function :ImGuizmo_PopID, [], :void

  attach_function :ImGuizmo_GetID_Str, [:string], :uint
  attach_function :ImGuizmo_GetID_StrStr, [:string, :string], :uint
  attach_function :ImGuizmo_GetID_Ptr, [:pointer], :uint

  attach_function :ImGuizmo_IsOver_OPERATION, [:uint], :bool
  attach_function :ImGuizmo_SetGizmoSizeClipSpace, [:float], :void
  attach_function :ImGuizmo_AllowAxisFlip, [:bool], :void
  attach_function :ImGuizmo_SetAxisLimit, [:float], :void
  attach_function :ImGuizmo_SetAxisMask, [:bool, :bool, :bool], :void
  attach_function :ImGuizmo_SetPlaneLimit, [:float], :void
  attach_function :ImGuizmo_IsOver_FloatPtr, [:pointer, :float], :bool

  attach_function :Style_Style, [], :pointer
  attach_function :Style_destroy, [:pointer], :void
  attach_function :ImGuizmo_GetStyle, [], :pointer

  #
  # Convenience helpers
  #
  def self.float_array_ptr(arr)
    ptr = FFI::MemoryPointer.new(:float, arr.length)
    arr.each_with_index { |v, i| ptr.put_float(i * FFI.type_size(:float), v) }
    ptr
  end

  def self.view_from_array(arr16)
    float_array_ptr(arr16)
  end

  def self.get_style
    p = ImGuizmo.ImGuizmo_GetStyle()
    style_from_ptr(FFI::Pointer.new(p))
  end
end
