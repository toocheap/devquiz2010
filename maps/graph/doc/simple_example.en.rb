require "graph"


#Create a undirected graph with four vertices 0, 1, 2, 3.
g= UndirectedHashGraph.new([0, 1, 2, 3])

#Create edges [0, 1], [0, 2], [1, 3], [2, 3] and set their weights.
g[0, 1]= 1.0
g[0, 2]= 2.0
g[1, 3]= 3.0
g[2, 3]= 4.0

#Get the shortest route from vertex 0 to 3, considering edge weight as edge length.
printf("[dijkstra_shortest_paths]\n")
dist= g.dijkstra_shortest_paths({
  :root        => 0,           #From vertex 0.
  :target      => 3,           #To vertex 3.
  :predecessor => (preds= {}), #Record the route info to Hash `preds'.
})
route= g.route(3, preds)       #Extract the route to vertex 3, using `preds'.
printf("The shortest route from 0 to 3 is %p, distance is %p.\n\n", route, dist)

#Get the maximum flow from vertex 0 to 3, considering edge weight as edge capacity.
printf("[maximum_flow]\n")
total= g.maximum_flow({
  :source => 0,          #From vertex 0.
  :sink   => 3,          #To vertex 3.
  :flow   => (flow= {}), #Record the flow of each edge to Hash `flow'.
})
printf("The maximum flow is %p.\nThe flow of each edge is %p.\n\n", total, flow)

#Perform a depth-first traversal of all vertices.
printf("[depth_first_search]  ")
g.depth_first_search({
  :root         => 0,    #Start from vertex 0.
  :on_tree_edge => proc{ |v, w| printf("%d->%d  ", v, w) },
                         #This Proc is called whenever a new vertex is discovered.
})
printf("\n\n")

#Perform a breadth-first traversal of all vertices.
printf("[breadth_first_search]  ")
g.breadth_first_search({
  :root         => 0,    #Start from vertex 0.
  :on_tree_edge => proc{ |v, w| printf("%d->%d  ", v, w) },
                         #This Proc is called whenever a new vertex is discovered.
})
printf("\n\n")

#Get the shortest paths from all vertices to all vertices at once.
printf("[warshall_floyd_shortest_paths]\n")
dist= g.warshall_floyd_shortest_paths({
  :predecessor => (preds= {}), #Record the route info to Hash `preds'.
  :distance    => (dists= {}), #Record the shortest path length between each vertex to Hash `dists'.
})
g.each_vertex do |v|
  g.each_vertex do |w|
    next if v==w
    route= g.route([v, w], preds)
      #Extract the route from vertex `v' to `w', using `preds'.
    printf("The shortest route from %d to %d is %p, distance is %p.\n",
      v, w, route, dists[[v, w]])
  end
end
