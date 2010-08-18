require "graph"


#4つの頂点0, 1, 2, 3を持つ無向グラフを作る。
g= UndirectedHashGraph.new([0, 1, 2, 3])

#辺[0, 1], [0, 2], [1, 3], [2, 3]を作り、各辺の重みを設定。
g[0, 1]= 1.0
g[0, 2]= 2.0
g[1, 3]= 3.0
g[2, 3]= 4.0

#各辺の重みを「辺の長さ」とみなして、頂点0から頂点3への最短経路を求めてみる。
printf("[dijkstra_shortest_paths]\n")
dist= g.dijkstra_shortest_paths({
  :root        => 0,           #頂点0からスタート。
  :target      => 3,           #頂点3がゴール。
  :predecessor => (preds= {}), #経路の情報をpredsというHashに記録。
})
route= g.route(3, preds)       #predsの情報から、頂点3への経路を取り出す。
printf("The shortest route from 0 to 3 is %p, distance is %p.\n\n", route, dist)

#各辺の重みを「辺の容量」とみなして、頂点0から頂点3まで流せる最大流量を求めてみる。
printf("[maximum_flow]\n")
total= g.maximum_flow({
  :source => 0,          #入口は頂点0。
  :sink   => 3,          #出口は頂点3。
  :flow   => (flow= {}), #各辺の流量をflowというHashに記録。
})
printf("The maximum flow is %p.\nThe flow of each edge is %p.\n\n", total, flow)

#深さ優先探索で全頂点を巡回してみる。
printf("[depth_first_search]  ")
g.depth_first_search({
  :root         => 0,    #頂点0からスタート。
  :on_tree_edge => proc{ |v, w| printf("%d->%d  ", v, w) },
                         #新しい頂点に進むたびにこのProcが呼ばれる。
})
printf("\n\n")

#幅優先探索で全頂点を巡回してみる。
printf("[breadth_first_search]  ")
g.breadth_first_search({
  :root         => 0,    #頂点0からスタート。
  :on_tree_edge => proc{ |v, w| printf("%d->%d  ", v, w) },
                         #新しい頂点に進むたびにこのProcが呼ばれる。
})
printf("\n\n")

#全頂点から全頂点への最短経路を一度に求めてみる。
printf("[warshall_floyd_shortest_paths]\n")
dist= g.warshall_floyd_shortest_paths({
  :predecessor => (preds= {}), #経路の情報をpredsというHashに記録。
  :distance    => (dists= {}), #各頂点間の最短距離をdistsというHashに記録。
})
g.each_vertex do |v|
  g.each_vertex do |w|
    next if v==w
    route= g.route([v, w], preds)
      #predsの情報から、頂点vから頂点wへの経路を取り出す。
    printf("The shortest route from %d to %d is %p, distance is %p.\n",
      v, w, route, dists[[v, w]])
  end
end
