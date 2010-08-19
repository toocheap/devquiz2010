=begin

=Module Graph

A module defining basic operations for a graph.

In order to make your own graph class, implement the following "Required methods"
and include this module.

==Module included:

* ((<GraphAlgorithm|URL:GraphAlgorithm.en.html>))

==Required methods:

--- self[ v, w ]
    
    The weight of the edge between vertex ((|v|)) and vertex ((|w|)).
    
    The "weight" is a value used as the length or capacity of the edge, by algorithms.
    
    If ((|v|)) and ((|w|)) are not adjacent, returns (({parameter(:default)}))
    (which defaults to (({nil}))).
    
--- each_vertex{ |v| ... }
    
    Repeats for each vertex of the graph.
    
--- directed?()
    
    If the graph is directed, returns (({true})).
    If the graph is undirected, returns (({false})).
    
    An undirected graph is a graph which satisfies (({self[v, w]==self[w, v]}))
    for any vertices (({v})), (({w})).
    
== Methods:

--- adjacent?(v, w)
    
    Returns (({true})) if vertex ((|v|)) and vertex ((|w|)) is adjacent
    (i.e. edge (({[v, w]})) exists).
    
    This is judged by (({self[v, w]!=parameter(:default)})).
    
    (({adjacent?(v, w)})) and (({adjacent?(w, v)})) is not always equal,
    in case of directed graph.
    
--- each_successing_vertex(v){ |w| ... }
    
    Repeats for each target vertex of all edges whose source vertex is ((|v|)).
    
--- each_edge(uniq= false){ |v, w| ... }
    
    Repeats for each edge of the graph.
    
    Repeats individually for (({v, w})) and (({w, v})), even if it's undirected graph.
    Set ((|uniq|)) to (({true})) in order to prevent this.
    
    ((|uniq|)) is ignored for directed graph.
    
--- out_degree(v)
    
    Returns the out degree of vertex ((|v|)) (the number of edges whose source vertex is ((|v|))).
    
--- vertices
    
    Returns all vertices as Array.
    
--- edges(uniq= false)
    
    Returns all edges as Array.
    
    ((|uniq|)) works the same as that of (({each_edge})).
    
--- parameter(name)
    
    Parameters of the graph. Used as the default value of the parameter for
    ((<GraphAlgorithm|URL:GraphAlgorithm.en.html>)) methods.
    
    (({parameter(:default)})) is the return value of (({self[v, w]}))
    if (({v})) and (({w})) is not adjacent.
    
    This always returns (({nil})) by default. Reimplement this if needed.
    
=end
