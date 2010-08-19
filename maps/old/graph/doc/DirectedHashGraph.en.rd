=begin

=Class DirectedHashGraph

An ordinary directed graph, using Hash.

==Module included:

* ((<Graph|URL:Graph.en.html>))

==Class methods:

--- DirectedHashGraph.new([vertices[, edges, [params]]])
    
    Creates a directed graph, which has ((|vertices|)) and ((|edges|)).
    
    Specify vertex Array for ((|vertices|)). (e.g. [0, 1, 2, 3])
    Any object comparable using Object#eql? can be a vertex.
    
    Specify edge Array for ((|edges|)). (e.g. [[0, 1, 1.0], [2, 3, 2.0]])
    Each edge consists of Array [source, target, weight].
    The weight is optional.
    
    The vertices and edges can be added later using (({add_vertex})), (({add_edge})).
    
    ((|params|)) is a Hash specifying the return value of ((<Graph|URL:Graph.en.html>))#parameter.
    Rarely used.

==Methods:

Common methods for graph classes are described at
((<Graph|URL:Graph.en.html>)), ((<GraphAlgorithm|URL:GraphAlgorithm.en.html>)).
See them.

--- self[ v, w ] = weight
    
    Sets the weight of edge (({[v, w]})) to ((|weight|)).
    
    Adds edge (({[v, w]})) if not exists.
    
--- add_edge(v, w[, weight])
    
    The same as (({self[v, w]= weight})).
    ((|weight|)) is set to (({1})) if omitted.
    
--- delete_edge(v, w)
    
    Deletes edge (({[v, w]})).
    
--- add_vertex(v)
    
    Adds vertex ((|v|)).
    
--- delete_vertex(v)
    
    Deletes vertex ((|v|)).
    
    Also deletes the edges whose source/target vertex is ((|v|)).
