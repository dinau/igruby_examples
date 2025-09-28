# frozen_string_literal: true
# Auto-generated Ruby-FFI bindings (from provided imnodes.h)
# Rules:
#  - short name = original name with prefix up to first '_' removed
#  - create short name only on first occurrence; subsequent collisions -> only original name binding
#  - also bind original name (except when short==original and already bound)
#  - bitshifts are computed; original expression preserved in comment
require "ffi"

module ImNodes
  extend FFI::Library
  ffi_lib get_imgui_dll_path()

  # ------------------------
  # Enums / constants
  # ------------------------

  # ImNodesCol_ (sequential)
  Col_NodeBackground = 0
  Col_NodeBackgroundHovered = 1
  Col_NodeBackgroundSelected = 2
  Col_NodeOutline = 3
  Col_TitleBar = 4
  Col_TitleBarHovered = 5
  Col_TitleBarSelected = 6
  Col_Link = 7
  Col_LinkHovered = 8
  Col_LinkSelected = 9
  Col_Pin = 10
  Col_PinHovered = 11
  Col_BoxSelector = 12
  Col_BoxSelectorOutline = 13
  Col_GridBackground = 14
  Col_GridLine = 15
  Col_GridLinePrimary = 16
  Col_MiniMapBackground = 17
  Col_MiniMapBackgroundHovered = 18
  Col_MiniMapOutline = 19
  Col_MiniMapOutlineHovered = 20
  Col_MiniMapNodeBackground = 21
  Col_MiniMapNodeBackgroundHovered = 22
  Col_MiniMapNodeBackgroundSelected = 23
  Col_MiniMapNodeOutline = 24
  Col_MiniMapLink = 25
  Col_MiniMapLinkSelected = 26
  Col_MiniMapCanvas = 27
  Col_MiniMapCanvasOutline = 28
  Col_COUNT = 29

  # ImNodesStyleVar_ (sequential)
  StyleVar_GridSpacing = 0
  StyleVar_NodeCornerRounding = 1
  StyleVar_NodePadding = 2
  StyleVar_NodeBorderThickness = 3
  StyleVar_LinkThickness = 4
  StyleVar_LinkLineSegmentsPerLength = 5
  StyleVar_LinkHoverDistance = 6
  StyleVar_PinCircleRadius = 7
  StyleVar_PinQuadSideLength = 8
  StyleVar_PinTriangleSideLength = 9
  StyleVar_PinLineThickness = 10
  StyleVar_PinHoverRadius = 11
  StyleVar_PinOffset = 12
  StyleVar_MiniMapPadding = 13
  StyleVar_MiniMapOffset = 14
  StyleVar_COUNT = 15

  # ImNodesStyleFlags_ (bitshifts computed; original in comment)
  StyleFlags_None = 0
  StyleFlags_NodeOutline = 1    # 1 << 0
  StyleFlags_GridLines = 4      # 1 << 2
  StyleFlags_GridLinesPrimary = 8  # 1 << 3
  StyleFlags_GridSnapping = 16  # 1 << 4

  # ImNodesPinShape_ (sequential)
  PinShape_Circle = 0
  PinShape_CircleFilled = 1
  PinShape_Triangle = 2
  PinShape_TriangleFilled = 3
  PinShape_Quad = 4
  PinShape_QuadFilled = 5

  # ImNodesAttributeFlags_ (bitshifts computed)
  AttributeFlags_None = 0
  AttributeFlags_EnableLinkDetachWithDragClick = 1  # 1 << 0
  AttributeFlags_EnableLinkCreationOnSnap = 2       # 1 << 1

  # ImNodesMiniMapLocation_ (sequential)
  MiniMapLocation_BottomLeft = 0
  MiniMapLocation_BottomRight = 1
  MiniMapLocation_TopLeft = 2
  MiniMapLocation_TopRight = 3

  # ------------------------
  # Minimal struct definitions (for by-value or field access)
  # ------------------------
  #

  # struct EmulateThreeButtonMouse
    class EmulateThreeButtonMouse < FFI::Struct
      layout :Modifier, :pointer  # const bool* -> :pointer
    end

    # struct LinkDetachWithModifierClick
    class LinkDetachWithModifierClick < FFI::Struct
      layout :Modifier, :pointer
    end

    # struct MultipleSelectModifier
    class MultipleSelectModifier < FFI::Struct
      layout :Modifier, :pointer
    end

    # struct ImNodesIO
    class ImNodesIO < FFI::Struct
      layout :EmulateThreeButtonMouse,     EmulateThreeButtonMouse.by_value,
             :LinkDetachWithModifierClick, LinkDetachWithModifierClick.by_value,
             :MultipleSelectModifier,      MultipleSelectModifier.by_value,
             :AltMouseButton,              :int,
             :AutoPanningSpeed,            :float
    end

  # Partial ImNodesStyle (colors array sized with ImNodesCol_COUNT)
  class ImNodesStyle < FFI::Struct
    layout :GridSpacing, :float,
           :NodeCornerRounding, :float,
           :NodePadding, ImVec2,
           :NodeBorderThickness, :float,
           :LinkThickness, :float,
           :LinkLineSegmentsPerLength, :float,
           :LinkHoverDistance, :float,
           :PinCircleRadius, :float,
           :PinQuadSideLength, :float,
           :PinTriangleSideLength, :float,
           :PinLineThickness, :float,
           :PinHoverRadius, :float,
           :PinOffset, :float,
           :MiniMapPadding, ImVec2,
           :MiniMapOffset, ImVec2,
           :Flags, :int,
           :Colors, [:uint, Col_COUNT]
  end

  # ------------------------
  # Function bindings (explicit, in header order)
  # Rule applied: create short name (part after first '_') on first occurrence only.
  # ------------------------

  # EmulateThreeButtonMouse* EmulateThreeButtonMouse_EmulateThreeButtonMouse(void);
  # short name => "EmulateThreeButtonMouse" (from first '_' in EmulateThreeButtonMouse_EmulateThreeButtonMouse)
  attach_function :EmulateThreeButtonMouse, :EmulateThreeButtonMouse_EmulateThreeButtonMouse, [], :pointer
  attach_function :EmulateThreeButtonMouse_EmulateThreeButtonMouse, [], :pointer

  # void EmulateThreeButtonMouse_destroy(EmulateThreeButtonMouse* self);
  # short name => "destroy" (from first '_' in EmulateThreeButtonMouse_destroy)
  # first occurrence of "destroy" -> create short alias
  attach_function :destroy, :EmulateThreeButtonMouse_destroy, [:pointer], :void
  attach_function :EmulateThreeButtonMouse_destroy, [:pointer], :void

  # LinkDetachWithModifierClick* LinkDetachWithModifierClick_LinkDetachWithModifierClick(void);
  # short name => "LinkDetachWithModifierClick"
  attach_function :LinkDetachWithModifierClick, :LinkDetachWithModifierClick_LinkDetachWithModifierClick, [], :pointer
  attach_function :LinkDetachWithModifierClick_LinkDetachWithModifierClick, [], :pointer

  # void LinkDetachWithModifierClick_destroy(LinkDetachWithModifierClick* self);
  # short name "destroy" already used -> only original
  attach_function :LinkDetachWithModifierClick_destroy, [:pointer], :void

  # MultipleSelectModifier* MultipleSelectModifier_MultipleSelectModifier(void);
  attach_function :MultipleSelectModifier, :MultipleSelectModifier_MultipleSelectModifier, [], :pointer
  attach_function :MultipleSelectModifier_MultipleSelectModifier, [], :pointer

  # void MultipleSelectModifier_destroy(MultipleSelectModifier* self);
  # short "destroy" used -> only original
  attach_function :MultipleSelectModifier_destroy, [:pointer], :void

  # ImNodesIO* ImNodesIO_ImNodesIO(void);
  attach_function :ImNodesIO, :ImNodesIO_ImNodesIO, [], :pointer
  attach_function :ImNodesIO_ImNodesIO, [], :pointer

  # void ImNodesIO_destroy(ImNodesIO* self);
  # short "destroy" used -> only original
  attach_function :ImNodesIO_destroy, [:pointer], :void

  # ImNodesStyle* ImNodesStyle_ImNodesStyle(void);
  attach_function :ImNodesStyle, :ImNodesStyle_ImNodesStyle, [], :pointer
  attach_function :ImNodesStyle_ImNodesStyle, [], :pointer

  # void ImNodesStyle_destroy(ImNodesStyle* self);
  # short "destroy" used -> only original
  attach_function :ImNodesStyle_destroy, [:pointer], :void

  # void imnodes_SetImGuiContext(ImGuiContext* ctx);
  # short name => "SetImGuiContext" (from imnodes_SetImGuiContext)
  attach_function :SetImGuiContext, :imnodes_SetImGuiContext, [:pointer], :void
  attach_function :imnodes_SetImGuiContext, [:pointer], :void

  # ImNodesContext* imnodes_CreateContext(void);
  # short => "CreateContext"
  attach_function :CreateContext, :imnodes_CreateContext, [], :pointer
  attach_function :imnodes_CreateContext, [], :pointer

  # void imnodes_DestroyContext(ImNodesContext* ctx);
  # short => "DestroyContext"
  attach_function :DestroyContext, :imnodes_DestroyContext, [:pointer], :void
  attach_function :imnodes_DestroyContext, [:pointer], :void

  # ImNodesContext* imnodes_GetCurrentContext(void);
  # short => "GetCurrentContext"
  attach_function :GetCurrentContext, :imnodes_GetCurrentContext, [], :pointer
  attach_function :imnodes_GetCurrentContext, [], :pointer

  # void imnodes_SetCurrentContext(ImNodesContext* ctx);
  # short => "SetCurrentContext"
  attach_function :SetCurrentContext, :imnodes_SetCurrentContext, [:pointer], :void
  attach_function :imnodes_SetCurrentContext, [:pointer], :void

  # ImNodesEditorContext* imnodes_EditorContextCreate(void);
  # short => "EditorContextCreate"
  attach_function :EditorContextCreate, :imnodes_EditorContextCreate, [], :pointer
  attach_function :imnodes_EditorContextCreate, [], :pointer

  # void imnodes_EditorContextFree(ImNodesEditorContext* noname1);
  # short => "EditorContextFree"
  attach_function :EditorContextFree, :imnodes_EditorContextFree, [:pointer], :void
  attach_function :imnodes_EditorContextFree, [:pointer], :void

  # void imnodes_EditorContextSet(ImNodesEditorContext* noname1);
  # short => "EditorContextSet"
  attach_function :EditorContextSet, :imnodes_EditorContextSet, [:pointer], :void
  attach_function :imnodes_EditorContextSet, [:pointer], :void

  # void imnodes_EditorContextGetPanning(ImVec2 *pOut);
  # short => "EditorContextGetPanning"
  attach_function :EditorContextGetPanning, :imnodes_EditorContextGetPanning, [:pointer], :void
  attach_function :imnodes_EditorContextGetPanning, [:pointer], :void

  # void imnodes_EditorContextResetPanning(const ImVec2 pos);
  # short => "EditorContextResetPanning"
  attach_function :EditorContextResetPanning, :imnodes_EditorContextResetPanning, [ImVec2.by_value], :void
  attach_function :imnodes_EditorContextResetPanning, [ImVec2.by_value], :void

  # void imnodes_EditorContextMoveToNode(const int node_id);
  # short => "EditorContextMoveToNode"
  attach_function :EditorContextMoveToNode, :imnodes_EditorContextMoveToNode, [:int], :void
  attach_function :imnodes_EditorContextMoveToNode, [:int], :void

  # ImNodesIO* imnodes_GetIO(void);
  # short => "GetIO"
  attach_function :GetIO, :imnodes_GetIO, [], :pointer
  attach_function :imnodes_GetIO, [], :pointer

  # ImNodesStyle* imnodes_GetStyle(void);
  # short => "GetStyle"
  attach_function :GetStyle, :imnodes_GetStyle, [], :pointer
  attach_function :imnodes_GetStyle, [], :pointer

  # void imnodes_StyleColorsDark(ImNodesStyle* dest);
  # short => "StyleColorsDark"
  attach_function :StyleColorsDark, :imnodes_StyleColorsDark, [:pointer], :void
  attach_function :imnodes_StyleColorsDark, [:pointer], :void

  # void imnodes_StyleColorsClassic(ImNodesStyle* dest);
  # short => "StyleColorsClassic"
  attach_function :StyleColorsClassic, :imnodes_StyleColorsClassic, [:pointer], :void
  attach_function :imnodes_StyleColorsClassic, [:pointer], :void

  # void imnodes_StyleColorsLight(ImNodesStyle* dest);
  # short => "StyleColorsLight"
  attach_function :StyleColorsLight, :imnodes_StyleColorsLight, [:pointer], :void
  attach_function :imnodes_StyleColorsLight, [:pointer], :void

  # void imnodes_BeginNodeEditor(void);
  # short => "BeginNodeEditor"
  attach_function :BeginNodeEditor, :imnodes_BeginNodeEditor, [], :void
  attach_function :imnodes_BeginNodeEditor, [], :void

  # void imnodes_EndNodeEditor(void);
  # short => "EndNodeEditor"
  attach_function :EndNodeEditor, :imnodes_EndNodeEditor, [], :void
  attach_function :imnodes_EndNodeEditor, [], :void

  # void imnodes_MiniMap(const float minimap_size_fraction,const ImNodesMiniMapLocation location,const ImNodesMiniMapNodeHoveringCallback node_hovering_callback,const ImNodesMiniMapNodeHoveringCallbackUserData node_hovering_callback_data);
  # short => "MiniMap"
  attach_function :MiniMap, :imnodes_MiniMap, [:float, :int, :pointer, :pointer], :void
  attach_function :imnodes_MiniMap, [:float, :int, :pointer, :pointer], :void

  # void imnodes_PushColorStyle(ImNodesCol item,unsigned int color);
  # short => "PushColorStyle"
  attach_function :PushColorStyle, :imnodes_PushColorStyle, [:int, :uint], :void
  attach_function :imnodes_PushColorStyle, [:int, :uint], :void

  # void imnodes_PopColorStyle(void);
  # short => "PopColorStyle"
  attach_function :PopColorStyle, :imnodes_PopColorStyle, [], :void
  attach_function :imnodes_PopColorStyle, [], :void

  # void imnodes_PushStyleVar_Float(ImNodesStyleVar style_item,float value);
  # short => "PushStyleVar_Float"
  attach_function :PushStyleVar_Float, :imnodes_PushStyleVar_Float, [:int, :float], :void
  attach_function :imnodes_PushStyleVar_Float, [:int, :float], :void

  # void imnodes_PushStyleVar_Vec2(ImNodesStyleVar style_item,const ImVec2 value);
  # short => "PushStyleVar_Vec2"
  attach_function :PushStyleVar_Vec2, :imnodes_PushStyleVar_Vec2, [:int, ImVec2.by_value], :void
  attach_function :imnodes_PushStyleVar_Vec2, [:int, ImVec2.by_value], :void

  # void imnodes_PopStyleVar(int count);
  # short => "PopStyleVar"
  attach_function :PopStyleVar, :imnodes_PopStyleVar, [:int], :void
  attach_function :imnodes_PopStyleVar, [:int], :void

  # void imnodes_BeginNode(int id);
  # short => "BeginNode"
  attach_function :BeginNode, :imnodes_BeginNode, [:int], :void
  attach_function :imnodes_BeginNode, [:int], :void

  # void imnodes_EndNode(void);
  # short => "EndNode"
  attach_function :EndNode, :imnodes_EndNode, [], :void
  attach_function :imnodes_EndNode, [], :void

  # void imnodes_GetNodeDimensions(ImVec2 *pOut,int id);
  # short => "GetNodeDimensions"
  attach_function :GetNodeDimensions, :imnodes_GetNodeDimensions, [:pointer, :int], :void
  attach_function :imnodes_GetNodeDimensions, [:pointer, :int], :void

  # void imnodes_BeginNodeTitleBar(void);
  # short => "BeginNodeTitleBar"
  attach_function :BeginNodeTitleBar, :imnodes_BeginNodeTitleBar, [], :void
  attach_function :imnodes_BeginNodeTitleBar, [], :void

  # void imnodes_EndNodeTitleBar(void);
  # short => "EndNodeTitleBar"
  attach_function :EndNodeTitleBar, :imnodes_EndNodeTitleBar, [], :void
  attach_function :imnodes_EndNodeTitleBar, [], :void

  # void imnodes_BeginInputAttribute(int id,ImNodesPinShape shape);
  # short => "BeginInputAttribute"
  attach_function :BeginInputAttribute, :imnodes_BeginInputAttribute, [:uint, :int], :void
  attach_function :imnodes_BeginInputAttribute, [:uint, :int], :void

  # void imnodes_EndInputAttribute(void);
  # short => "EndInputAttribute"
  attach_function :EndInputAttribute, :imnodes_EndInputAttribute, [], :void
  attach_function :imnodes_EndInputAttribute, [], :void

  # void imnodes_BeginOutputAttribute(int id,ImNodesPinShape shape);
  # short => "BeginOutputAttribute"
  attach_function :BeginOutputAttribute, :imnodes_BeginOutputAttribute, [:uint, :int], :void
  attach_function :imnodes_BeginOutputAttribute, [:uint, :int], :void

  # void imnodes_EndOutputAttribute(void);
  # short => "EndOutputAttribute"
  attach_function :EndOutputAttribute, :imnodes_EndOutputAttribute, [], :void
  attach_function :imnodes_EndOutputAttribute, [], :void

  # void imnodes_BeginStaticAttribute(int id);
  # short => "BeginStaticAttribute"
  attach_function :BeginStaticAttribute, :imnodes_BeginStaticAttribute, [:uint], :void
  attach_function :imnodes_BeginStaticAttribute, [:uint], :void

  # void imnodes_EndStaticAttribute(void);
  # short => "EndStaticAttribute"
  attach_function :EndStaticAttribute, :imnodes_EndStaticAttribute, [], :void
  attach_function :imnodes_EndStaticAttribute, [], :void

  # void imnodes_PushAttributeFlag(ImNodesAttributeFlags flag);
  # short => "PushAttributeFlag"
  attach_function :PushAttributeFlag, :imnodes_PushAttributeFlag, [:int], :void
  attach_function :imnodes_PushAttributeFlag, [:int], :void

  # void imnodes_PopAttributeFlag(void);
  # short => "PopAttributeFlag"
  attach_function :PopAttributeFlag, :imnodes_PopAttributeFlag, [], :void
  attach_function :imnodes_PopAttributeFlag, [], :void

  # void imnodes_Link(int id,int start_attribute_id,int end_attribute_id);
  # short => "Link"
  attach_function :Link, :imnodes_Link, [:int, :int, :int], :void
  attach_function :imnodes_Link, [:int, :int, :int], :void

  # void imnodes_SetNodeDraggable(int node_id,const bool draggable);
  # short => "SetNodeDraggable"
  attach_function :SetNodeDraggable, :imnodes_SetNodeDraggable, [:int, :bool], :void
  attach_function :imnodes_SetNodeDraggable, [:int, :bool], :void

  # void imnodes_SetNodeScreenSpacePos(int node_id,const ImVec2 screen_space_pos);
  # short => "SetNodeScreenSpacePos"
  attach_function :SetNodeScreenSpacePos, :imnodes_SetNodeScreenSpacePos, [:int, ImVec2.by_value], :void
  attach_function :imnodes_SetNodeScreenSpacePos, [:int, ImVec2.by_value], :void

  # void imnodes_SetNodeEditorSpacePos(int node_id,const ImVec2 editor_space_pos);
  # short => "SetNodeEditorSpacePos"
  attach_function :SetNodeEditorSpacePos, :imnodes_SetNodeEditorSpacePos, [:int, ImVec2.by_value], :void
  attach_function :imnodes_SetNodeEditorSpacePos, [:int, ImVec2.by_value], :void

  # void imnodes_SetNodeGridSpacePos(int node_id,const ImVec2 grid_pos);
  # short => "SetNodeGridSpacePos"
  attach_function :SetNodeGridSpacePos, :imnodes_SetNodeGridSpacePos, [:int, ImVec2.by_value], :void
  attach_function :imnodes_SetNodeGridSpacePos, [:int, ImVec2.by_value], :void

  # void imnodes_GetNodeScreenSpacePos(ImVec2 *pOut,const int node_id);
  # short => "GetNodeScreenSpacePos"
  attach_function :GetNodeScreenSpacePos, :imnodes_GetNodeScreenSpacePos, [:pointer, :int], :void
  attach_function :imnodes_GetNodeScreenSpacePos, [:pointer, :int], :void

  # void imnodes_GetNodeEditorSpacePos(ImVec2 *pOut,const int node_id);
  # short => "GetNodeEditorSpacePos"
  attach_function :GetNodeEditorSpacePos, :imnodes_GetNodeEditorSpacePos, [:pointer, :int], :void
  attach_function :imnodes_GetNodeEditorSpacePos, [:pointer, :int], :void

  # void imnodes_GetNodeGridSpacePos(ImVec2 *pOut,const int node_id);
  # short => "GetNodeGridSpacePos"
  attach_function :GetNodeGridSpacePos, :imnodes_GetNodeGridSpacePos, [:pointer, :int], :void
  attach_function :imnodes_GetNodeGridSpacePos, [:pointer, :int], :void

  # void imnodes_SnapNodeToGrid(int node_id);
  # short => "SnapNodeToGrid"
  attach_function :SnapNodeToGrid, :imnodes_SnapNodeToGrid, [:int], :void
  attach_function :imnodes_SnapNodeToGrid, [:int], :void

  # bool imnodes_IsEditorHovered(void);
  # short => "IsEditorHovered"
  attach_function :IsEditorHovered, :imnodes_IsEditorHovered, [], :bool
  attach_function :imnodes_IsEditorHovered, [], :bool

  # bool imnodes_IsNodeHovered(int* node_id);
  # short => "IsNodeHovered"
  attach_function :IsNodeHovered, :imnodes_IsNodeHovered, [:pointer], :bool
  attach_function :imnodes_IsNodeHovered, [:pointer], :bool

  # bool imnodes_IsLinkHovered(int* link_id);
  # short => "IsLinkHovered"
  attach_function :IsLinkHovered, :imnodes_IsLinkHovered, [:pointer], :bool
  attach_function :imnodes_IsLinkHovered, [:pointer], :bool

  # bool imnodes_IsPinHovered(int* attribute_id);
  # short => "IsPinHovered"
  attach_function :IsPinHovered, :imnodes_IsPinHovered, [:pointer], :bool
  attach_function :imnodes_IsPinHovered, [:pointer], :bool

  # int imnodes_NumSelectedNodes(void);
  # short => "NumSelectedNodes"
  attach_function :NumSelectedNodes, :imnodes_NumSelectedNodes, [], :int
  attach_function :imnodes_NumSelectedNodes, [], :int

  # int imnodes_NumSelectedLinks(void);
  # short => "NumSelectedLinks"
  attach_function :NumSelectedLinks, :imnodes_NumSelectedLinks, [], :int
  attach_function :imnodes_NumSelectedLinks, [], :int

  # void imnodes_GetSelectedNodes(int* node_ids);
  # short => "GetSelectedNodes"
  attach_function :GetSelectedNodes, :imnodes_GetSelectedNodes, [:pointer], :void
  attach_function :imnodes_GetSelectedNodes, [:pointer], :void

  # void imnodes_GetSelectedLinks(int* link_ids);
  # short => "GetSelectedLinks"
  attach_function :GetSelectedLinks, :imnodes_GetSelectedLinks, [:pointer], :void
  attach_function :imnodes_GetSelectedLinks, [:pointer], :void

  # void imnodes_ClearNodeSelection_Nil(void);
  # short => "ClearNodeSelection_Nil"
  attach_function :ClearNodeSelection_Nil, :imnodes_ClearNodeSelection_Nil, [], :void
  attach_function :imnodes_ClearNodeSelection_Nil, [], :void

  # void imnodes_ClearLinkSelection_Nil(void);
  # short => "ClearLinkSelection_Nil"
  attach_function :ClearLinkSelection_Nil, :imnodes_ClearLinkSelection_Nil, [], :void
  attach_function :imnodes_ClearLinkSelection_Nil, [], :void

  # void imnodes_SelectNode(int node_id);
  # short => "SelectNode"
  attach_function :SelectNode, :imnodes_SelectNode, [:int], :void
  attach_function :imnodes_SelectNode, [:int], :void

  # void imnodes_ClearNodeSelection_Int(int node_id);
  # short => "ClearNodeSelection_Int"
  attach_function :ClearNodeSelection_Int, :imnodes_ClearNodeSelection_Int, [:int], :void
  attach_function :imnodes_ClearNodeSelection_Int, [:int], :void

  # bool imnodes_IsNodeSelected(int node_id);
  # short => "IsNodeSelected"
  attach_function :IsNodeSelected, :imnodes_IsNodeSelected, [:int], :bool
  attach_function :imnodes_IsNodeSelected, [:int], :bool

  # void imnodes_SelectLink(int link_id);
  # short => "SelectLink"
  attach_function :SelectLink, :imnodes_SelectLink, [:int], :void
  attach_function :imnodes_SelectLink, [:int], :void

  # void imnodes_ClearLinkSelection_Int(int link_id);
  # short => "ClearLinkSelection_Int"
  attach_function :ClearLinkSelection_Int, :imnodes_ClearLinkSelection_Int, [:int], :void
  attach_function :imnodes_ClearLinkSelection_Int, [:int], :void

  # bool imnodes_IsLinkSelected(int link_id);
  # short => "IsLinkSelected"
  attach_function :IsLinkSelected, :imnodes_IsLinkSelected, [:int], :bool
  attach_function :imnodes_IsLinkSelected, [:int], :bool

  # bool imnodes_IsAttributeActive(void);
  # short => "IsAttributeActive"
  attach_function :IsAttributeActive, :imnodes_IsAttributeActive, [], :bool
  attach_function :imnodes_IsAttributeActive, [], :bool

  # bool imnodes_IsAnyAttributeActive(int* attribute_id);
  # short => "IsAnyAttributeActive"
  attach_function :IsAnyAttributeActive, :imnodes_IsAnyAttributeActive, [:pointer], :bool
  attach_function :imnodes_IsAnyAttributeActive, [:pointer], :bool

  # bool imnodes_IsLinkStarted(int* started_at_attribute_id);
  # short => "IsLinkStarted"
  attach_function :IsLinkStarted, :imnodes_IsLinkStarted, [:pointer], :bool
  attach_function :imnodes_IsLinkStarted, [:pointer], :bool

  # bool imnodes_IsLinkDropped(int* started_at_attribute_id,bool including_detached_links);
  # short => "IsLinkDropped"
  attach_function :IsLinkDropped, :imnodes_IsLinkDropped, [:pointer, :bool], :bool
  attach_function :imnodes_IsLinkDropped, [:pointer, :bool], :bool

  # bool imnodes_IsLinkCreated_BoolPtr(int* started_at_attribute_id,int* ended_at_attribute_id,bool* created_from_snap);
  # short => "IsLinkCreated_BoolPtr"
  attach_function :IsLinkCreated_BoolPtr, :imnodes_IsLinkCreated_BoolPtr, [:pointer, :pointer, :pointer], :bool
  attach_function :imnodes_IsLinkCreated_BoolPtr, [:pointer, :pointer, :pointer], :bool

  # bool imnodes_IsLinkCreated_IntPtr(int* started_at_node_id,int* started_at_attribute_id,int* ended_at_node_id,int* ended_at_attribute_id,bool* created_from_snap);
  # short => "IsLinkCreated_IntPtr"
  attach_function :IsLinkCreated_IntPtr, :imnodes_IsLinkCreated_IntPtr, [:pointer, :pointer, :pointer, :pointer, :pointer], :bool
  attach_function :imnodes_IsLinkCreated_IntPtr, [:pointer, :pointer, :pointer, :pointer, :pointer], :bool

  # bool imnodes_IsLinkDestroyed(int* link_id);
  # short => "IsLinkDestroyed"
  attach_function :IsLinkDestroyed, :imnodes_IsLinkDestroyed, [:pointer], :bool
  attach_function :imnodes_IsLinkDestroyed, [:pointer], :bool

  # const char* imnodes_SaveCurrentEditorStateToIniString(size_t* data_size);
  # short => "SaveCurrentEditorStateToIniString"
  attach_function :SaveCurrentEditorStateToIniString, :imnodes_SaveCurrentEditorStateToIniString, [:pointer], :pointer
  attach_function :imnodes_SaveCurrentEditorStateToIniString, [:pointer], :pointer

  # const char* imnodes_SaveEditorStateToIniString(const ImNodesEditorContext* editor,size_t* data_size);
  # short => "SaveEditorStateToIniString"
  attach_function :SaveEditorStateToIniString, :imnodes_SaveEditorStateToIniString, [:pointer, :pointer], :pointer
  attach_function :imnodes_SaveEditorStateToIniString, [:pointer, :pointer], :pointer

  # void imnodes_LoadCurrentEditorStateFromIniString(const char* data,size_t data_size);
  # short => "LoadCurrentEditorStateFromIniString"
  #attach_function :LoadCurrentEditorStateFromIniString, :imnodes_LoadCurrentEditorStateToIniString = :imnodes_LoadCurrentEditorStateFromIniString rescue :imnodes_LoadCurrentEditorStateFromIniString
  # Note: the above line attempted to alias short name; fallback to original binding below for robustness
  attach_function :imnodes_LoadCurrentEditorStateFromIniString, [:pointer, :size_t], :void
  # Also bind short name properly:
  attach_function :LoadCurrentEditorStateFromIniString, :imnodes_LoadCurrentEditorStateFromIniString, [:pointer, :size_t], :void

  # void imnodes_LoadEditorStateFromIniString(ImNodesEditorContext* editor,const char* data,size_t data_size);
  # short => "LoadEditorStateFromIniString"
  attach_function :LoadEditorStateFromIniString, :imnodes_LoadEditorStateFromIniString, [:pointer, :pointer, :size_t], :void
  attach_function :imnodes_LoadEditorStateFromIniString, [:pointer, :pointer, :size_t], :void

  # void imnodes_SaveCurrentEditorStateToIniFile(const char* file_name);
  # short => "SaveCurrentEditorStateToIniFile"
  attach_function :SaveCurrentEditorStateToIniFile, :imnodes_SaveCurrentEditorStateToIniFile, [:pointer], :void
  attach_function :imnodes_SaveCurrentEditorStateToIniFile, [:pointer], :void

  # void imnodes_SaveEditorStateToIniFile(const ImNodesEditorContext* editor,const char* file_name);
  # short => "SaveEditorStateToIniFile"
  attach_function :SaveEditorStateToIniFile, :imnodes_SaveEditorStateToIniFile, [:pointer, :pointer], :void
  attach_function :imnodes_SaveEditorStateToIniFile, [:pointer, :pointer], :void

  # void imnodes_LoadCurrentEditorStateFromIniFile(const char* file_name);
  # short => "LoadCurrentEditorStateFromIniFile"
  attach_function :LoadCurrentEditorStateFromIniFile, :imnodes_LoadCurrentEditorStateFromIniFile, [:pointer], :void
  attach_function :imnodes_LoadCurrentEditorStateFromIniFile, [:pointer], :void

  # void imnodes_LoadEditorStateFromIniFile(ImNodesEditorContext* editor,const char* file_name);
  # short => "LoadEditorStateFromIniFile"
  attach_function :LoadEditorStateFromIniFile, :imnodes_LoadEditorStateFromIniFile, [:pointer, :pointer], :void
  attach_function :imnodes_LoadEditorStateFromIniFile, [:pointer, :pointer], :void

  # bool* getIOKeyCtrlPtr();
  # no '_' prefix to cut -> bind original only (short name undefined)
  attach_function :getIOKeyCtrlPtr, [], :pointer

  # End of bindings
end
