=begin

=Module GraphAlgorithm

A module providing algorithms for a graph.

This is included by ((<Graph|URL:Graph.en.html>)).
So, The following methods can be called as methods of graph classes
(((<UndirectedHashGraph|URL:UndirectedHashGraph.en.html>)), etc).

I recommend to see ((<simple_example.en.rb|URL:simple_example.en.rb>)) first,
rather than the following document.

== Methods:

--- depth_first_search(params)
    
    Performs a depth-first traversal of the vertices in the graph.
    
    All parameters are specified in Hash ((|params|)).
    The following shows valid parameters.
    
    :(({params[:root]}))
      Essential. Specify a vertex. The traversal is started from here.
    :(({params[:target]}))
      Optional. Specify a vertex. The traversal finishes when it discovers here.
    :(({params[:predecessor]}))
      Optional. Specify a Hash. If the traversal go from vertex (({v})) to (({w})),
        params[:predecessor][w]= v
      is executed.
    :(({params[:vertex_number]}))
      Optional. Specify a Hash. If it visits vertex (({v})) to the (({n}))-th,
        params[:vertex_number][v]= n
      is executed.
    :(({params[:on_discover_vertex]}))
      Optional. Specify a Proc or Method. When it discovers vertex (({v})),
        params[:on_discover_vertex].call(v)
      is executed.
    :(({params[:on_tree_edge]}))
      Optional. Specify a Proc or Method. If the traversal go from vertex (({v})) to (({w})),
        params[:on_tree_edge].call(v, w)
      is executed.
    :(({params[:adjacent?]}))
      Optional. Specify a Proc, Method or Hash.
      Edge (({[v, w]})) is "closed" if the result of
      (({params[:adjacent?].call(v, w)})) (for Proc or Method) or
      (({params[:adjacent?][[v, w]]})) (for Hash) is false.
    
    Returns (({true})) if (({params[:target]})) is specified and discovered.
    
--- breadth_first_search(params)
    
    Performs a breadth-first traversal of the vertices in the graph.
    
    All parameters are specified in Hash ((|params|)).
    Valid parameters are the same as (({depth_first_search})).
    
    Returns (({true})) if (({params[:target]})) is specified and discovered.
    
--- dijkstra_shortest_paths(params)
    
    Solves the shortest-paths problem on the graph using Dijkstra's algorithm.
    
    All edge lengths (weights) must be nonnegative.
    
    All parameters are specified in Hash ((|params|)).
    The following shows valid parameters.
    
    :(({params[:root]}))
      Essential. Specify a vertex. Searches shortest paths from here to each vertex.
    :(({params[:target]}))
      Optional. Specify a vertex. Stops searching when the shortest path to this
      is got. Note that the shortest paths to the vertices except this may not have been got
      when searching is stopped.
      
      If (({params[:target]})) is omitted, Searching is finished after the shortest paths
      to all vertices is got.
    :(({params[:predecessor]}))
      Optional. Specify a Hash. If the shortest path to vertex (({w})) ends with edge (({[v, w]})),
        params[:predecessor][w]= v
      is executed.
    :(({params[:distance]}))
      Optional. Specify a Hash. If the shortest path length from (({params[:root]}))
      to (({v})) is (({d})),
        params[:distance][v]= d
      is executed.
    :(({params[:on_examine_vertex]}))
      Optional. Specify a Proc or Method.
        params[:on_examine_vertex].call(v)
      is executed before starting examining the routes through (({v})).
    :(({params[:on_relax_edge]}))
      Optional. Specify a Proc or Method.
        params[:on_relax_edge].call(v, w)
      is executed when the route to vertex (({w})) is changed to the route through
      edge (({v, w})).
    :(({params[:adjacent?]}))
      Optional. Specify a Proc, Method or Hash.
      Edge (({[v, w]})) is "closed" if the result of
      (({params[:adjacent?].call(v, w)})) (for Proc or Method) or
      (({params[:adjacent?][[v, w]]})) (for Hash) is false.
    :(({params[:weight]}))
      Optional. Specify a Proc, Method or Hash.
      Edge (({[v, w]}))'s length (weight) is the result of
      (({params[:weight].call(v, w)})) (for Proc or Method) or
      (({params[:weight][[v, w]]})) (for Hash).
      
      (({self[v, w]})) is used if omitted.
    :(({params[:zero]}))
      Optional. The object representing "zero distance".
      (({0})) is used if omitted. This satisfies most of the cases.
    :(({params[:infinity]}))
      Optional. The object representing "infinite distance".
      (({1.0/0.0})) is used if omitted. This satisfies most of the cases.
    
    Returns the shortest path length from (({params[:root]})) to (({params[:target]}))
    if (({params[:target]})) is specified and reachable.
    
    Otherwise, returns (({nil})).
    
--- warshall_floyd_shortest_paths(params)
    
    Solves the shortest-paths problem on the graph using Warshall-Floyd algorithm.
    
    Edges with negative length (weight) is allowed.
    Gets shortest paths from all vertices to all vertices at once.
    But the time complexity is direct proportion to the cube of the number of vertices.
    
    All parameters are specified in Hash ((|params|)).
    The following shows valid parameters.
    
    :(({params[:predecessor]}))
      Optional. Specify a Hash. For example, the shortest path from  (({v})) to (({w})) is
      (({[v, x, y, w]})) ,
        params[:predecessor][[v, w]]= y
        params[:predecessor][[v, y]]= x
        params[:predecessor][[v, x]]= v
      is executed.
    :(({params[:distance]}))
      Optional. Specify a Hash. If the shortest path length from (({v})) to (({w})) is (({d})),
        params[:distance][[v, w]]= d
      is executed.
    :(({params[:on_examine_edge]}))
      Optional. Specify a Proc or Method.
        params[:on_examine_edge].call(v, w)
      is executed before starting examining the routes through edge (({[v, w]})).
    :(({params[:on_relax_edge]}))
      Optional. Specify a Proc or Method.
        params[:on_relax_edge].call(v, w, x)
      is executed when the route from vertex (({v})) to (({w})) is changed to the route
      through edge (({[x, w]})).
    :(({params[:adjacent?]}))
      Optional. Specify a Proc, Method or Hash.
      Edge (({[v, w]})) is "closed" if the result of
      (({params[:adjacent?].call(v, w)})) (for Proc or Method) or
      (({params[:adjacent?][[v, w]]})) (for Hash) is false.
    :(({params[:weight]}))
      Optional. Specify a Proc, Method or Hash.
      Edge (({[v, w]}))'s length (weight) is the result of
      (({params[:weight].call(v, w)})) (for Proc or Method) or
      (({params[:weight][[v, w]]})) (for Hash).
      
      (({self[v, w]})) is used if omitted.
    :(({params[:zero]}))
      Optional. The object representing "zero distance".
      (({0})) is used if omitted. This satisfies most of the cases.
    :(({params[:infinity]}))
      Optional. The object representing "infinite distance".
      (({1.0/0.0})) is used if omitted. This satisfies most of the cases.
    
    Returns (({nil})).
    
--- maximum_flow(params)
    
    Gets the maximum flow from some vertex to another vertex,
    considering edge weight as edge capacity.
    
    All parameters are specified in Hash ((|params|)).
    The following shows valid parameters.
    
    :(({params[:source]}))
      Essential. Specify a vertex which is source of the flow.
    :(({params[:sink]}))
      Essential. Specify a vertex which is sink of the flow.
    :(({params[:flow]}))
      Optional. Specify a Hash. If the flow of edge (({[v, w]})) is (({f})),
        params[:flow][[v, w]]= f
      is executed.
    :(({params[:rest]}))
      Optional. Specify a Hash. If edge (({[v, w]})) can pour more (({r})) flow,
        params[:rest][[v, w]]= r
      is executed.
    :(({params[:on_add_flow]}))
      Optional. Specify a Proc or Method.
        params[:on_add_flow].call(route, inc)
      is executed when flow (({inc})) is added to the (({route})).
      (({route})) is (({[[v, w], [w, x]]})) if the route is (({v})) -> (({w})) -> (({x})).
    :(({params[:adjacent?]}))
      Optional. Specify a Proc, Method or Hash.
      Edge (({[v, w]})) is "closed" if the result of
      (({params[:adjacent?].call(v, w)})) (for Proc or Method) or
      (({params[:adjacent?][[v, w]]})) (for Hash) is false.
    :(({params[:weight]}))
      Optional. Specify a Proc, Method or Hash.
      Edge (({[v, w]}))'s length (weight) is the result of
      (({params[:weight].call(v, w)})) (for Proc or Method) or
      (({params[:weight][[v, w]]})) (for Hash).
      
      (({self[v, w]})) is used if omitted.
    :(({params[:zero]}))
      Optional. The object representing "zero distance".
      (({0})) is used if omitted. This satisfies most of the cases.
    
    Returns the maximum flow from (({params[:source]})) to (({params[:sink]})).
    
--- route(target, predecessor[, mode])
    
    Returns the route to vertex ((|target|)), using the (({params[:predecessor]}))
    recorded by (({depth_first_search})), (({breadth_first_search})),
    (({djikstra_shortest_paths})), (({warshall_floyd_shortest_paths})).
    
    Exceptionally, ((|target|)) must be an Array [source, target]
    in case of (({warshall_floyd_shortest_paths})).
    
    ((|predecessor|)) is a Hash specified to (({params[:predecessor]})) in the above methods.
    
    Returns the vertices on the route if ((|mode|)) is (({:vertex})) or omitted.
    Returns the edges on the route if ((|mode|)) is (({:edge})).
    
--- graphviz_format(params)
    
    Output the graph as ((<Graphviz|URL:http://www.graphviz.org/>)) DOT format.
    Input the output of this method to ((<Graphviz|URL:http://www.graphviz.org/>)) dot command
    to visualize the graph.
    
    All parameters are specified in Hash ((|params|)).
    The following shows valid parameters.
    
    :(({params[:io]}))
      Optional. Specify an IO object for the output.
    :(({params[:graph_id]}))
      Optional. Specify a String used as the graph ID.
    :(({params[:vertex_id]}))
      Optional. Specify Proc, Method or Hash.
      (({params[:vertex_id][v]})) is used as the ID of vertex (({v})).
      (({v.to_s()})) is used if omitted.
      
      The character available for ID is limited. See
      ((<The DOT Language|URL:http://www.graphviz.org/cvs/doc/info/lang.html>)).
    :(({params[:vertex_attribute]}))
      Optional. Specify a Proc, Method or Hash.
      (({params[:vertex_attribute][v]})) is used as the attribute Hash of vertex (({v})).
    :(({params[:edge_label]}))
      Optional. Specify a Proc, Method or Hash.
      (({params[:edge_label].call(v, w)})) ((({params[:edge_label][[v, w]]})) for Hash)
      is used as the label of edge (({[v, w]})).
    :(({params[:edge_attribute]}))
      Optional. Specify a Proc, Method or Hash.
      (({params[:edge_attribute].call(v, w)})) ((({params[:edge_attribute][[v, w]]})) for Hash)
      is used as the attribute Hash of edge (({[v, w]})).
    :(({params[:extra]}))
      Optional. Specify a String describing additional grpah attributes, etc. This String is
      output as is right after
        (graph|digraph) [ID] '{'
    
    Returns (({params[:io]})) if (({params[:io]})) is specified.
    Otherwise, returns the output as String.
    
=end
