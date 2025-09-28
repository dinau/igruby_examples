# coding: utf-8
#
require_relative '../utils/appImGui'
require_relative '../libs/imnodes'

# Simple Ruby data classes
class Node
  attr_accessor :id, :value
  def initialize(id: 0, value: 0.0)
    @id = id
    @value = value.to_f
  end
end

class Link
  attr_accessor :id, :start_attr, :end_attr
  def initialize(id:, start_attr:, end_attr:)
    @id = id
    @start_attr = start_attr
    @end_attr = end_attr
  end
end

class RecObj
  attr_accessor :nodes, :links, :current_id
  def initialize
    @nodes = []
    @links = []
    @current_id = 0
  end
end

#-------------
# Persistence     Save/load helpers use binary packing
#-------------
module Persistence
  extend self

  def save(obj, filename: 'save_load.bytes')
    # Save imnodes ini first
    ImNodes.SaveCurrentEditorStateToIniFile('save_load.ini')
    File.open(filename, 'wb') do |f|
      # Write nodes size (usize) -> use 64-bit unsigned on most systems
      f.write([obj.nodes.length].pack('Q'))
      obj.nodes.each do |n|
        f.write([n.id].pack('i'))
        f.write([n.value].pack('f'))
      end
      f.write([obj.links.length].pack('Q'))
      obj.links.each do |l|
        f.write([l.id].pack('i'))
        f.write([l.start_attr].pack('i'))
        f.write([l.end_attr].pack('i'))
      end
      f.write([obj.current_id].pack('i'))
    end
  end

  def load(obj, filename: 'save_load.bytes')
    # Load imnodes ini first (will be no-op if not exists)
    ImNodes.LoadCurrentEditorStateFromIniFile('save_load.ini')
    return unless File.exist?(filename)
    File.open(filename, 'rb') do |f|
      # read nodes count
      nodes_sz_data = f.read(8)
      return unless nodes_sz_data
      nodes_sz = nodes_sz_data.unpack1('Q')
      puts "Node num: #{nodes_sz}"
      if nodes_sz == 0
        return
      end
      nodes_sz.times do
        id = f.read(4).unpack1('i')
        if id < 0
          id = 0
        end
        value = f.read(4).unpack1('f')
        puts "Node#{id}, value: #{value}"
        obj.nodes << Node.new(id: id, value: value)
      end
      links_sz = f.read(8).unpack1('Q')
      links_sz.times do
        id = f.read(4).unpack1('i')
        start_attr = f.read(4).unpack1('i')
        end_attr = f.read(4).unpack1('i')
        obj.links << Link.new(id: id, start_attr: start_attr, end_attr: end_attr)
      end
      obj.current_id = f.read(4).unpack1('i')
    end
  end
end

#----------
# gui_main
#----------
def gui_main(window)

  # Setup fonts
  setupFonts()

  # Other definitions
  imnodes_context = ImNodes.imnodes_CreateContext()
  obj = RecObj.new

  # Configure imnodes IO
  imnodes_io = ImNodes::ImNodesIO.new(ImNodes.GetIO())
  imnodes_io[:LinkDetachWithModifierClick][:Modifier] = ImNodes.getIOKeyCtrlPtr()
  ImNodes.PushAttributeFlag(ImNodes::AttributeFlags_EnableLinkDetachWithDragClick)

  Persistence.load(obj)

  #-----------
  # main loop
  #-----------
  while GLFW.WindowShouldClose( window.handle ) == 0
    window.pollEvents()

    # Iconify sleep
    if window.isIconified()
        next
    end

    newFrame()

    ImGui::ShowDemoWindow(nil)

    #---------------------
    # Show ImNodes window
    #---------------------
    ImGui::Begin("ImGui window in Ruby  " + ICON_FA_WIFI + " 2025/09", nil)
    begin
      ImGui.TextUnformatted("A -- add node", nil)
      ImGui.TextUnformatted("\"Close the executable and rerun it -- your nodes should be exactly\"\n\"where you left them !\"", nil)

      ImNodes.BeginNodeEditor()
      begin
        # If A key released while focused and editor hovered -> add node
        if ImGui.IsWindowFocused(ImGuiFocusedFlags_RootAndChildWindows) && ImNodes.IsEditorHovered() && ImGui.IsKeyReleased(ImGuiKey_A)
          obj.current_id += 1
          node_id = obj.current_id
          pos = ImGui.GetMousePos()
          # set node pos
          ImNodes.SetNodeScreenSpacePos(node_id, pos)

          obj.nodes << Node.new(id: node_id, value: 0.0)
        end
        # iterate nodes
        obj.nodes.each_with_index do |node, nodeN|
          ImNodes.BeginNode(node.id)
          begin
            ImNodes.BeginNodeTitleBar()
              ImGui.Text("%s %d", :string, "node", :int, nodeN) # igText with formatting: use igTextUnformatted for simplicity
            ImNodes.EndNodeTitleBar()

            ImNodes.BeginInputAttribute(node.id << 8, ImNodes::PinShape_CircleFilled)
              ImGui.TextUnformatted("input", nil)
            ImNodes.EndInputAttribute()

            ImNodes.BeginStaticAttribute(node.id << 16)
            begin
              ImGui.PushItemWidth(120.0)
              # Drag float: we must provide pointer to a C float
              f_buf = FFI::MemoryPointer.new(:float)
              f_buf.write_float(node.value)
              ImGui.DragFloat("value", f_buf, 0.01, 0.0, 0.0, "%.3f", 0)
              node.value = f_buf.read_float
              ImGui.PopItemWidth()
            ensure
              ImNodes.EndStaticAttribute()
            end
            ImNodes.BeginOutputAttribute(node.id << 24, ImNodes::PinShape_CircleFilled)
            begin
              wOut = ImGui.CalcTextSize("output", nil, false, -1.0)
              wVal = ImGui.CalcTextSize("value", nil, false, -1.0)
              ImGui.Indent(120 + wVal[:x] - wOut[:x])
              ImGui.TextUnformatted("output", nil)
            ensure
              ImNodes.EndOutputAttribute()
            end
          ensure
            ImNodes.EndNode()
          end
        end # end do
        # draw links
        obj.links.each do |link|
          ImNodes.Link(link.id, link.start_attr, link.end_attr)
        end
      ensure
        ImNodes.EndNodeEditor()
      end
      # check link creation
      l_start = FFI::MemoryPointer.new(:int)
      l_end = FFI::MemoryPointer.new(:int)
      if ImNodes.IsLinkCreated_BoolPtr(l_start, l_end, nil)
        obj.current_id += 1
        lnk = Link.new(id: obj.current_id, start_attr: l_start.read_int, end_attr: l_end.read_int)
        obj.links << lnk
      end
      # check link destroyed
      link_id_ptr = FFI::MemoryPointer.new(:int)
      if ImNodes.IsLinkDestroyed(link_id_ptr)
        link_id = link_id_ptr.read_int
        idx = obj.links.index { |it| it.id == link_id }
        obj.links.delete_at(idx) if idx
      end
    ensure
       ImGui.End()
    end

    #--------
    # Render
    #--------
    render(window)

  end # end main loop

  Persistence.save(obj)
  ImNodes.imnodes_DestroyContext(imnodes_context)

end # end gui_main

#------
# main
#------
def main()
    begin
      window = createImGui(title:"ImGui: Ruby window", titleBarIcon:"./res/r.png")
      gui_main(window)
    ensure
      destroyImGui(window) # Free resources
    end
end

if __FILE__ == $PROGRAM_NAME
  main()
end
