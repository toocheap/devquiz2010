#Ruby/Graph Ver.0.2

#http://raa.ruby-lang.org/project/graph/
#Created by Gimite Ichikawa <gimite@mx12.freecom.ne.jp>
#This library is Public Domain.

#------------------------------------------------------------------------------#

require "set"
require "stringio"

#------------------------------------------------------------------------------#

class GraphAlgorithmHelper
  
  def initialize(g, p)
    @graph= g
    @params= p
    @vert_num= 0
  end
  
  def handle(type, *args)
    if p= @params[type]
      p.call(*args)
    end
  end
  
  def record(type, key, value)
    if p= @params[type]
      p[key]= value
    end
  end
  
  def on_tree_edge(v, w)
    handle(:on_tree_edge, v, w) if !v.eql?(w)
    record(:predecessor, w, v)
  end
  
  def on_discover_vertex(v)
    handle(:on_discover_vertex, v)
    record(:vertex_number, v, @vert_num)
    @vert_num+= 1
  end
  
  def on_examine_vertex(v)
    handle(:on_examine_vertex, v)
  end
  
  def weight(v, w)
    if call_parameter(:adjacent?, v, w){ @graph.adjacent?(v, w) }
      return call_parameter(:weight, v, w){ @graph[v, w] } || infinity
    else
      return infinity
    end
  end
  
  def adjacent?(v, w)
    return weight(v, w)<infinity
  end
  
  def each_successing_vertex(v, &block)
    @graph.each_successing_vertex(v) do |w|
      block.call(w) if adjacent?(v, w)
    end
  end
  
  def each_edge(uniq= false, &block)
    @graph.each_edge(uniq) do |v, w|
      block.call(v, w) if adjacent?(v, w)
    end
  end
  
  def infinity
    return parameter(:infinity) || 1.0/0.0
  end
  
  def zero
    return parameter(:zero) || 0
  end
  
  def parameter(name)
    return @params[name] || @graph.parameter(name)
  end
  
  def call_parameter(name, *args, &default)
    p= parameter(name)
    if !p
      return default && default.call(args)
    elsif p.is_a?(Proc) || p.is_a?(Method)
      return p.call(*args)
    else
      return p[args.size==1 ? args[0] : args]
    end
  end
  
end

#------------------------------------------------------------------------------#
module GraphAlgorithm
  
  def depth_first_search(params)
    h= GraphAlgorithmHelper.new(self, params)
    target= h.parameter(:target)
    v= h.parameter(:root)
    predecs= {v => v}
    h.on_discover_vertex(v)
    h.on_tree_edge(v, v)
    return true if v.eql?(target)
    while true
      w= nil
      h.each_successing_vertex(v) do |x|
        if !predecs[x]
          w= x
          break
        end
      end
      if w
        predecs[w]= v
        h.on_discover_vertex(w)
        h.on_tree_edge(v, w)
        return true if w.eql?(target)
        v= w
      elsif predecs[v].eql?(v)
        return false
      else
        v= predecs[v]
      end
    end
  end
  
  def breadth_first_search(params)
    h= GraphAlgorithmHelper.new(self, params)
    root= h.parameter(:root)
    target= h.parameter(:target)
    found_verts= Set.new()
    que= [root]
    found_verts.add(root)
    h.on_discover_vertex(root)
    h.on_tree_edge(root, root)
    return true if root.eql?(target)
    while !que.empty?()
      v= que.delete_at(0)
      h.each_successing_vertex(v) do |w|
        if !found_verts.include?(w)
          que.push(w)
          found_verts.add(w)
          h.on_discover_vertex(w)
          h.on_tree_edge(v, w)
          return true if w.eql?(target)
        end
      end
    end
    return false
  end
  
  def dijkstra_shortest_paths(params)
    h= GraphAlgorithmHelper.new(self, params)
    root= h.parameter(:root)
    target= h.parameter(:target)
    dists= Hash.new(h.infinity)
    found_verts= Set.new()
    dists[root]= h.zero
    h.record(:distance, root, h.zero)
    h.record(:predecessor, root, root)
    while true
      min_d= h.infinity
      v= nil
      for w, d in dists
        if !found_verts.include?(w) && d<min_d
          v= w
          min_d= d
        end
      end
      return nil if min_d==h.infinity
      return dists[v] if v.eql?(target)
      h.on_examine_vertex(v)
      h.each_successing_vertex(v) do |w|
        wt= h.weight(v, w)
        if dists[v]+wt<dists[w]
          dists[w]= dists[v]+wt
          h.record(:distance, w, dists[w])
          h.record(:predecessor, w, v)
          h.handle(:on_relax_edge, v, w)
        end
      end
      found_verts.add(v)
    end
  end
  
  def warshall_floyd_shortest_paths(params)
    h= GraphAlgorithmHelper.new(self, params)
    dists= Hash.new(h.infinity)
    predecs= {}
    each_vertex() do |w|
      each_vertex() do |v|
        dists[[v, w]]= v.eql?(w) ? h.zero : h.weight(v, w)
        predecs[[v, w]]= v
        h.record(:distance, [v, w], dists[[v, w]])
        h.record(:predecessor, [v, w], predecs[[v, w]])
      end
    end
    each_vertex() do |x|
      each_vertex() do |w|
        next if w.eql?(x)
        h.handle(:on_examine_edge, x, w)
        each_vertex() do |v|
          next if v.eql?(x)
          dvw= dists[[v, w]]
          dvx= dists[[v, x]]
          dxw= dists[[x, w]]
          if dvx+dxw<dvw
            dists[[v, w]]= dvx+dxw
            predecs[[v, w]]= predecs[[x, w]]
            h.record(:distance, [v, w], dists[[v, w]])
            h.record(:predecessor, [v, w], predecs[[v, w]])
            h.handle(:on_relax_edge, v, w, x)
          end
        end
      end
    end
    return nil
  end
  
  def maximum_flow(params)
    h= GraphAlgorithmHelper.new(self, params)
    source= h.parameter(:source)
    sink= h.parameter(:sink)
    flow= Hash.new(h.zero)
    rest= Hash.new(h.zero)
    total_flow= h.zero
    h.each_edge() do |v, w|
      rest[[v, w]]= h.weight(v, w)
      h.record(:rest, [v, w], rest[[v, w]])
    end
    while true
      pred= {}
      breadth_first_search({
        :root => source, :target => sink,
        :adjacent? => proc(){ |v, w| rest[[v, w]]>h.zero },
        :predecessor => pred
      })
      break if !pred[sink]
      rt= route(sink, pred, :edge)
      inc= rt.map(){ |w, v| rest[[w, v]] }.min()
      for w, v in rt
        flow[[w, v]]+= inc
        rest[[w, v]]-= inc
        rest[[v, w]]+= inc
        h.record(:flow, [w, v], flow[[w, v]])
        h.record(:rest, [w, v], rest[[w, v]])
        h.record(:rest, [v, w], rest[[v, w]])
      end
      total_flow+= inc
      h.handle(:on_add_flow, rt, inc)
    end
    return total_flow
  end
  
  def route(target, preds, mode= :vertex)
    (root, target)= target if target.is_a?(Array)
    r= mode==:vertex ? [target] : []
    v= target
    while true
      w= root ? preds[[root, v]] : preds[v]
      return r if w.eql?(v)
      r.unshift(mode==:vertex ? w : [w, v])
      v= w
    end
  end
  
  def graphviz_format(params)
    h= GraphAlgorithmHelper.new(self, params)
    io= h.parameter(:io) || (sio= StringIO.new())
    
    attr_to_str= proc() do |attr|
      strs= attr.to_a().map() do |key, val|
        format("%s=\"%s\"", key, val.to_s().gsub(/"/){ "\\\"" })
      end
      strs.join(",")
    end
    vertex_id= proc(){ |v| h.call_parameter(:vertex_id, v){ v.to_s() } }
    
    graph_id= h.parameter(:graph_id) || ""
    io.printf("%s %s {\n", directed?() ? "digraph" : "graph", graph_id)
    io.print(h.parameter(:extra) || "")
    each_edge(true) do |v, w|
      eattr= (h.call_parameter(:edge_attribute, v, w) || {}).dup()
      eattr["label"]||= h.call_parameter(:edge_label, v, w){ self[v, w] }
      io.printf("  %s %s %s [%s];\n",
        vertex_id.call(v),
        directed?() ? "->" : "--",
        vertex_id.call(w),
        attr_to_str.call(eattr))
    end
    each_vertex do |v|
      vattr= h.call_parameter(:vertex_attribute, v)
       if vattr
        io.printf("  %s [%s];\n", vertex_id.call(v), attr_to_str.call(vattr))
      end
    end
    io.printf("}\n")
    return sio ? sio.string : io
  end
  
end

#------------------------------------------------------------------------------#
