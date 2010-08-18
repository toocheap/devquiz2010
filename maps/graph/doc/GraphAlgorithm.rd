=begin

=GraphAlgorithm モジュール

グラフのアルゴリズム集。

((<Graph|URL:Graph.html>)) にインクルードされているので、
以下のメソッドはグラフクラス(
((<UndirectedHashGraph|URL:UndirectedHashGraph.html>))など)の
メソッドとして呼び出せます。

いきなり以下の説明を読むより、 ((<simple_example.rb|URL:simple_example.rb>))
を見た方が分かりやすいと思います。

== メソッド:

--- depth_first_search(params)
    
    グラフに対して、深さ優先探索を行います。
    
    パラメータは全て、ハッシュ ((|params|)) に指定します。
    有効なパラメータを以下に示します。
    
    :(({params[:root]}))
      必須。探索を始める頂点を指定します。
    :(({params[:target]}))
      省略可。この頂点にたどり着いたら、探索を終了します。
    :(({params[:predecessor]}))
      省略可。 Hash を指定すると、その Hash に
      「それぞれの頂点に到達する直前にどの頂点を通ったか」が記録されます。
    :(({params[:vertex_number]}))
      省略可。 Hash を指定すると、その Hash に
      「それぞれの頂点に何番目に到達したか」が記録されます。
    :(({params[:on_discover_vertex]}))
      省略可。Proc か Method を指定すると、頂点 (({v})) に到達した時に、
      (({params[:on_discover_vertex].call(v)})) が実行されます。
    :(({params[:on_tree_edge]}))
      省略可。Proc か Method を指定すると、頂点 (({v})) から
      頂点 (({w})) に進んだ時に、
      (({params[:on_tree_edge].call(v, w)})) が実行されます。
    :(({params[:adjacent?]}))
      省略可。Proc か Method なら (({params[:adjacent?].call(v, w)})) 、
      それ以外なら (({params[:adjacent?][[v, w]]})) が呼ばれ、
      その戻り値が偽ならば、辺 (({[v, w]})) は「通行止め」になります。
    
    (({params[:target]})) が指定されていて、そこに到達できた場合は
    (({true})) を返します。
    
--- breadth_first_search(params)
    
    グラフに対して、幅優先探索を行います。
    
    パラメータは全て、ハッシュ ((|params|)) に指定します。
    有効なパラメータは (({depth_first_search})) と同じです。
    
    (({params[:target]})) が指定されていて、そこに到達できた場合は
    (({true})) を返します。
    
--- dijkstra_shortest_paths(params)
    
    グラフに対して、Dijkstraのアルゴリズムで最短経路を求めます。
    
    辺の長さ(重み)は全て 0 以上でなければなりません。
    
    パラメータは全て、ハッシュ ((|params|)) に指定します。
    有効なパラメータを以下に示します。
    
    :(({params[:root]}))
      必須。この頂点から各頂点への最短経路を求めます。
    :(({params[:target]}))
      省略可。この頂点への最短距離が求まったら、探索を終了します。
      逆に言えば、探索が終了した時点で、指定された以外の頂点への
      最短経路は求まっていないかもしれません。
      (({params[:target]})) を省略した場合は、全ての頂点への最短経路が
      求まってから終了します。
    :(({params[:predecessor]}))
      省略可。 Hash を指定すると、その Hash に
      「それぞれの頂点に最短経路で行くには、直前にどの頂点を通ればいいか」
      が記録されます。
    :(({params[:distance]}))
      省略可。 Hash を指定すると、その Hash に
      「 (({params[:root]})) から各頂点への最短距離」が記録されます。
    :(({params[:on_examine_vertex]}))
      省略可。Proc か Method を指定すると、頂点 (({v}))
      を経由する経路の調査が始まる前に、
      (({params[:on_examine_vertex].call(v)})) が実行されます。
    :(({params[:on_relax_edge]}))
      省略可。Proc か Method を指定すると、頂点 (({w})) に行く経路を、
      辺 (({[v, w]})) を経由する経路に変更した時に、
      (({params[:on_relax_edge].call(v, w)})) が実行されます。
    :(({params[:adjacent?]}))
      省略可。Proc か Method なら (({params[:adjacent?].call(v, w)})) 、
      それ以外なら (({params[:adjacent?][[v, w]]})) が呼ばれ、
      その戻り値が偽ならば、辺 (({[v, w]})) は「通行止め」になります。
    :(({params[:weight]}))
      省略可。Proc か Method なら (({params[:weight].call(v, w)})) 、
      それ以外なら (({params[:weight][[v, w]]})) が呼ばれ、
      その戻り値を辺 (({[v, w]})) の長さ(重み)とみなします。
      省略した場合は、 (({self[v, w]})) が使われます。
    :(({params[:zero]}))
      省略可。「距離ゼロ」を表すオブジェクトです。
      省略すると (({0})) になります。ほとんどの場合はこれで問題無いでしょう。
    :(({params[:infinity]}))
      省略可。「距離無限大」を表すオブジェクトです。
      省略すると (({1.0/0.0})) になります。ほとんどの場合はこれで問題無いでしょう。
    
    (({params[:target]})) が指定されていて、そこに到達できた場合は、
    (({params[:root]})) から (({params[:target]})) への最短距離を返します。
    
    それ以外の場合は、 (({nil})) を返します。
    
--- warshall_floyd_shortest_paths(params)
    
    グラフに対して、Warshall Floydのアルゴリズムで最短経路を求めます。
    
    負の長さ(重み)を持つ辺があっても構いません。
    また、全頂点から全頂点への最短経路を一度に求めます。
    ただし、頂点数の3乗に比例して遅くなります。
    
    パラメータは全て、ハッシュ ((|params|)) に指定します。
    有効なパラメータを以下に示します。
    
    :(({params[:predecessor]}))
      省略可。 例えば頂点 (({v})) から頂点 (({w})) に行く最短経路が
      (({[v, x, y, w]})) だった場合、
        params[:predecessor][[v, w]]= y
        params[:predecessor][[v, y]]= x
        params[:predecessor][[v, x]]= v
      と記録されます。
    :(({params[:distance]}))
      省略可。 頂点 (({v})) から頂点 (({w})) への最短距離が (({d}))
      ならば、
        params[:distance][[v, w]]= d
      と記録されます。
    :(({params[:on_examine_edge]}))
      省略可。Proc か Method を指定すると、辺 (({[v, w]}))
      を経由する経路の調査が始まる前に、
      (({params[:on_examine_edge].call(v, w)})) が実行されます。
    :(({params[:on_relax_edge]}))
      省略可。Proc か Method を指定すると、頂点 (({v})) から頂点 (({w}))
      に行く経路を、辺 (({[x, w]})) を経由する経路に変更した時に、
      (({params[:on_relax_edge].call(v, w, x)})) が実行されます。
    :(({params[:adjacent?]}))
      省略可。Proc か Method なら (({params[:adjacent?].call(v, w)})) 、
      それ以外なら (({params[:adjacent?][[v, w]]})) が呼ばれ、
      その戻り値が偽ならば、辺 (({[v, w]})) は「通行止め」になります。
    :(({params[:weight]}))
      省略可。Proc か Method なら (({params[:weight].call(v, w)})) 、
      それ以外なら (({params[:weight][[v, w]]})) が呼ばれ、
      その戻り値を辺 (({[v, w]})) の長さ(重み)とみなします。
      省略した場合は、 (({self[v, w]})) が使われます。
    :(({params[:zero]}))
      省略可。「距離ゼロ」を表すオブジェクトです。
      省略すると (({0})) になります。ほとんどの場合はこれで問題無いでしょう。
    :(({params[:infinity]}))
      省略可。「距離無限大」を表すオブジェクトです。
      省略すると (({1.0/0.0})) になります。ほとんどの場合はこれで問題無いでしょう。
    
    (({nil})) を返します。
    
--- maximum_flow(params)
    
    辺の重みを辺の容量とみなし、ある頂点からある頂点まで、
    最大どれだけ流す事ができるかを求めます。
    
    パラメータは全て、ハッシュ ((|params|)) に指定します。
    有効なパラメータを以下に示します。
    
    :(({params[:source]}))
      必須。入口となる頂点(ソース)を指定します。
    :(({params[:sink]}))
      必須。出口となる頂点(シンク)を指定します。
    :(({params[:flow]}))
      省略可。 Hash を指定すると、その Hash に
      「それぞれの辺の流量」が記録されます。
    :(({params[:rest]}))
      省略可。 Hash を指定すると、その Hash に
      「それぞれの辺にあとどれだけ流せるか」が記録されます。
    :(({params[:on_add_flow]}))
      省略可。Proc か Method を指定すると、流量を (({inc})) だけ追加する時に、
      (({params[:on_add_flow].call(route, inc)})) が実行されます。
      (({route})) は流す経路を表します。例えば経路 (({v})) → (({w})) → (({x}))
      なら、 (({route})) は (({[[v, w], [w, x]]})) になります。
    :(({params[:adjacent?]}))
      省略可。Proc か Method なら (({params[:adjacent?].call(v, w)})) 、
      それ以外なら (({params[:adjacent?][[v, w]]})) が呼ばれ、
      その戻り値が偽ならば、辺 (({[v, w]})) は「通行止め」になります。
    :(({params[:weight]}))
      省略可。Proc か Method なら (({params[:weight].call(v, w)})) 、
      それ以外なら (({params[:weight][[v, w]]})) が呼ばれ、
      その戻り値を辺 (({[v, w]})) の容量(重み)とみなします。
      省略した場合は、 (({self[v, w]})) が使われます。
    :(({params[:zero]}))
      省略可。「流量ゼロ」を表すオブジェクトです。
      省略すると (({0})) になります。ほとんどの場合はこれで問題無いでしょう。
    
    (({params[:source]})) から (({params[:sink]}))
    までに流す事ができる最大流量を返します。
    
--- route(target, predecessor[, mode])
    
    (({depth_first_search})) 、 (({breadth_first_search})) 、 
    (({djikstra_shortest_paths})) 、 (({warshall_floyd_shortest_paths}))
    で (({params[:predecessor]})) に記録された情報を元に、頂点 ((|target|))
    までの経路を求めて返します。
    
    ただし、 (({warshall_floyd_shortest_paths})) の場合は、 ((|target|))
    に [始点, 終点] という配列を指定します。
    
    ((|predecessor|)) には、 (({params[:predecessor]})) に指定した Hash
    を指定します。
    
    ((|mode|)) に (({:vertex})) (デフォルト)を指定すると経路上の頂点を、
    (({:edge})) を指定すると経路上の辺を返します。
    
--- graphviz_format(params)
    
    グラフを((<Graphviz|URL:http://www.graphviz.org/>))のDOT形式で出力します。
    このメソッドの出力を((<Graphviz|URL:http://www.graphviz.org/>))のdotコマンドに
    入力すると、グラフを視覚化できます。
    
    パラメータは全て、ハッシュ ((|params|)) に指定します。
    有効なパラメータを以下に示します。
    
    :(({params[:io]}))
      省略可。出力先の IO オブジェクト。
    :(({params[:graph_id]}))
      省略可。グラフのIDとして使われる文字列。
    :(({params[:vertex_id]}))
      省略可。 Proc か Method か Hash を指定。
      (({params[:vertex_id][v]})) が頂点 (({v})) のIDとして使われます。
      省略すると、 (({v.to_s()})) が使われます。
      
      IDに使える文字には制限が有ります。
      ((<The DOT Language|URL:http://www.graphviz.org/cvs/doc/info/lang.html>))
      を参照してください。
    :(({params[:vertex_attribute]}))
      省略可。 Proc か Method か Hash を指定。
      (({params[:vertex_attribute][v]})) が頂点 (({v}))
      の属性を表す Hash として使われます。
    :(({params[:edge_label]}))
      省略可。 Proc か Method か Hash を指定。
      (({params[:edge_label].call(v, w)})) (Hashの場合は
      (({params[:edge_label][[v, w]]})) )が辺 (({[v, w]}))
      のラベルとして使われます。
    :(({params[:edge_attribute]}))
      省略可。 Proc か Method か Hash を指定。
      (({params[:edge_attribute].call(v, w)})) (Hashの場合は
      (({params[:edge_attribute][[v, w]]})) )が辺 (({[v, w]}))
      の属性を表す Hash として使われます。
    :(({params[:extra]}))
      省略可。グラフの追加の属性などを指定します。この文字列は
        (graph|digraph) [ID] '{'
      の直後にそのまま出力されます。
    
    (({params[:io]})) が指定された場合は (({params[:io]}))
    を、そうでなければ出力内容を文字列で返します。
    
=end
