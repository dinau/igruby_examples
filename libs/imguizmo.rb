# imguizmo.rb
# Generated from ImGuizmo.h — bitwise expressions replaced by computed integers;
# original expressions kept as comments for reference.

require 'ffi'
module ImGuizmo
  extend FFI::Library
  ffi_lib get_imgui_dll_path()

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
  LOCAL =  0
  WORLD =  1

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

  attach_function :SetDrawlist,:ImGuizmo_SetDrawlist, [:pointer], :void
  attach_function :BeginFrame, :ImGuizmo_BeginFrame, [], :void
  attach_function :SetImGuiContext, :ImGuizmo_SetImGuiContext, [:pointer], :void
  attach_function :IsOver_Nil, :ImGuizmo_IsOver_Nil, [], :bool
  attach_function :IsUsing, :ImGuizmo_IsUsing, [], :bool
  attach_function :IsUsingViewManipulate, :ImGuizmo_IsUsingViewManipulate, [], :bool
  attach_function :IsViewManipulateHovered, :ImGuizmo_IsViewManipulateHovered, [], :bool
  attach_function :IsUsingAny, :ImGuizmo_IsUsingAny, [], :bool
  attach_function :Enable, :ImGuizmo_Enable, [:bool], :void
  attach_function :RecomposeMatrixFromComponents,:ImGuizmo_DecomposeMatrixToComponents, [:pointer, :pointer, :pointer, :pointer], :void
  attach_function :RecomposeMatrixFromComponents,:ImGuizmo_RecomposeMatrixFromComponents, [:pointer, :pointer, :pointer, :pointer], :void
  attach_function :SetRect, :ImGuizmo_SetRect, [:float, :float, :float, :float], :void
  attach_function :SetOrthographic, :ImGuizmo_SetOrthographic, [:bool], :void
  attach_function :DrawCubes, :ImGuizmo_DrawCubes, [:pointer, :pointer, :pointer, :int], :void
  attach_function :DrawGrid, :ImGuizmo_DrawGrid, [:pointer, :pointer, :pointer, :float], :void
  attach_function :Manipulate, :ImGuizmo_Manipulate,
                  [:pointer, :pointer, :uint, :uint, :pointer, :pointer, :pointer, :pointer, :pointer],
                  :bool
  attach_function :ViewManipulate_Float, :ImGuizmo_ViewManipulate_Float, [:pointer, :float, ImVec2.by_value, ImVec2.by_value, :uint], :void
  attach_function :ViewManipulate_FloatPtr, :ImGuizmo_ViewManipulate_FloatPtr,
                  [:pointer, :pointer, :uint, :uint, :pointer, :float, ImVec2.by_value, ImVec2.by_value, :uint],
                  :void
  attach_function :SetAlternativeWindow, :ImGuizmo_SetAlternativeWindow, [:pointer], :void
  attach_function :SetID, :ImGuizmo_SetID, [:int], :void
  attach_function :PushID_Str, :ImGuizmo_PushID_Str, [:string], :void
  attach_function :PushID_StrStr, :ImGuizmo_PushID_StrStr, [:string, :string], :void
  attach_function :PushID_Ptr, :ImGuizmo_PushID_Ptr, [:pointer], :void
  attach_function :PushID_Int, :ImGuizmo_PushID_Int, [:int], :void
  attach_function :PopID, :ImGuizmo_PopID, [], :void
  attach_function :GetID_Str, :ImGuizmo_GetID_Str, [:string], :uint
  attach_function :GetID_StrStr, :ImGuizmo_GetID_StrStr, [:string, :string], :uint
  attach_function :GetID_Ptr, :ImGuizmo_GetID_Ptr, [:pointer], :uint
  attach_function :IsOver_OPERATION, :ImGuizmo_IsOver_OPERATION, [:uint], :bool
  attach_function :SetGizmoSizeClipSpace, :ImGuizmo_SetGizmoSizeClipSpace, [:float], :void
  attach_function :AllowAxisFlip, :ImGuizmo_AllowAxisFlip, [:bool], :void
  attach_function :SetAxisLimit, :ImGuizmo_SetAxisLimit, [:float], :void
  attach_function :SetAxisMask, :ImGuizmo_SetAxisMask, [:bool, :bool, :bool], :void
  attach_function :SetPlaneLimit, :ImGuizmo_SetPlaneLimit, [:float], :void
  attach_function :IsOver_FloatPtr, :ImGuizmo_IsOver_FloatPtr, [:pointer, :float], :bool
  attach_function :Style_Style, [], :pointer
  attach_function :Style_destroy, :Style_destroy, [:pointer], :void
  attach_function :GetStyle, :ImGuizmo_GetStyle, [], :pointer
end
