# 
# Depth first search
#

require 'pp'

class Graph
    def initialize(edges)
        @edges = edges
        @nodes = Hash.new{|h,k| h[k] = []}
    end

    def add_edge(edge)
        @edges.push edge unless @edges.index(edge)
    end

    def add_node(u, v)
        if @edges.index(u).nil?
            @edges.push u
        elsif @edges.index(v).nil?
            @edges.push v
        end

        unless @nodes[u].index(v)
            @nodes[u].push v
        end
    end

    def dfs(s)
        stack = []
        stack.push s
        explored = []
        while(!stack.empty?)
            u = stack.shift
            if explored.include?(u) == false
                explored.push u
                @nodes[u].each{|v|
                    stack.unshift v
                }
            end
        end
        return explored
    end

end
__END__
g = Graph.new(["1", "2", "3"])
g.add_edge("8")
g.add_edge("3")

g.add_node("3", "2")
g.add_node("1", "5")
g.add_node("1", "6")
g.add_node("5", "8")
g.add_node("2", "6")
g.add_node("1", "3")
g.add_node("2", "9")
pp g
pp g.dfs("1")

