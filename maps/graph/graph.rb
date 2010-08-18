#Ruby/Graph Ver.0.2

#http://raa.ruby-lang.org/project/graph/
#Created by Gimite Ichikawa <gimite@mx12.freecom.ne.jp>
#This library is Public Domain.

#-----------------------------------------------------------------------#

require "set"
require "graph_algorithm"

#-----------------------------------------------------------------------#

module Graph
  
  include(GraphAlgorithm)
  
  #def [](v, w)
  #def each_vertex(&block)
  #def directed?()
  
  def adjacent?(v, w)
    return self[v, w]!=parameter(:default)
  end
  
  def each_successing_vertex(v, &block)
    each_vertices() do |w|
      block.call(w) if adjacent?(v, w)
    end
  end
  
  def each_edge(uniq= false, &block)
    i= 0
    each_vertex() do |v|
      j= 0
      each_vertex() do |w|
        block.call(v, w) if (!uniq || directed?() || j>=i) && adjacent?(v, w)
        j+= 1
      end
      i+= 1
    end
  end
  
  def out_degree(v)
    deg= 0
    each_successing_vertex(v) do |w|
      deg+= 1
    end
    return deg
  end
  
  def vertices
    result= []
    each_vertex() do |v|
      result.push(v)
    end
    return result
  end
  
  def edges(uniq= false)
    result= []
    each_edge(uniq) do |e|
      result.push(e)
    end
    return result
  end
  
  def parameter(name)
    return nil
  end
  
end

#-----------------------------------------------------------------------#

class DirectedHashGraph
  
  include(Graph)
  
  def initialize(vs= [], es= [], ps= {})
    @params= ps
    @vertices= {}
    vs.each(){ |v| add_vertex(v) }
    @weights= {}
    for e in es
      add_edge(*e)
    end
  end
  
  def [](v, w)
    assure(v)
    return @weights[v][w]
  end
  
  def each_vertex(&block)
    for v, n in @vertices
      block.call(v)
    end
  end
  
  def directed?()
    return true
  end
  
  def each_successing_vertex(v, &block)
    assure(v)
    @weights[v].each_key do |w|
      block.call(w)
    end
  end
  
  def each_edge(uniq= false, &block)
    for v, wts in @weights
      for w, wt in wts
        block.call(v, w)
      end
    end
  end
  
  def out_degree(v)
    assure(v)
    return @weights[v].size
  end
  
  def parameter(name)
    return @params[name]
  end
  
  def []=(v, w, weight)
    add_vertex(v)
    add_vertex(w)
    if weight!=parameter(:default)
      assure(v)
      @weights[v][w]= weight
    else
      delete_edge(v, w)
    end
    return weight
  end
  
  def add_edge(v, w, weight= 1)
    self[v, w]= weight
  end
  
  def delete_edge(v, w)
    assure(v)
    @weights[v].delete(w)
  end
  
  def add_vertex(v)
    @vertices[v]= number() if !@vertices.has_key?(v)
  end
  
  def delete_vertex(v)
    @vertices.delete(v)
    @weights.delete(v)
    for w, wts in @weights
      wts.delete(v)
    end
  end
  
  def vertex_id(v)
    return @vertices[v]
  end
  
private
  
  def number()
    return 0
  end
  
  def assure(v)
    @weights[v]= Hash.new(parameter(:default)) if !@weights.has_key?(v)
  end
  
end

#-----------------------------------------------------------------------#

class UndirectedHashGraph < DirectedHashGraph
  
  def initialize(*args)
    @number= 0
    super(*args)
  end
  
  def directed?()
    return false
  end
  
  def each_edge(uniq= false, &block)
    for v, wts in @weights
      for w, wt in wts
        block.call(v, w) if !uniq || vertex_id(v)<=vertex_id(w)
      end
    end
  end
  
  def []=(v, w, weight)
    super(v, w, weight)
    super(w, v, weight)
  end
  
  def delete_edge(v, w)
    super(v, w)
    super(w, v)
  end
  
private
  
  def number()
    @number+= 1
    return @number-1
  end
  
end

#-----------------------------------------------------------------------#
