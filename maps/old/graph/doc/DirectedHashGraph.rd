=begin

=DirectedHashGraph クラス

Hash を使って実装した、普通の有向グラフ。

==インクルードしているモジュール:

* ((<Graph|URL:Graph.html>))

==クラスメソッド:

--- DirectedHashGraph.new([vertices[, edges, [params]]])
    
    頂点 ((|vertices|)) 、辺 ((|edges|)) を持つ有向グラフを作ります。
    
    ((|vertices|)) には頂点の配列を指定します(例: [0, 1, 2, 3])。
    頂点は Object#eql? で等値比較できるオブジェクトなら、何でもいいです。
    
    ((|edges|)) には辺の配列を指定します(例: [[0, 1, 1.0], [2, 3, 2.0]])。
    各辺は [始点, 終点, 重み] という配列で指定します。
    重みは省略可能です。
    
    頂点と辺は、あとから (({add_vertex})) 、 (({add_edge})) などで
    追加できます。
    
    ((|params|)) は ((<Graph|URL:Graph.html>))#parameter の戻り値を設定する
    パラメータです。あまり使いません。

==メソッド:

グラフクラス共通のメソッドの説明は
((<Graph|URL:Graph.html>)) 、((<GraphAlgorithm|URL:GraphAlgorithm.html>))
に有ります。参照してください。

--- self[ v, w ] = weight
    
    辺 (({[v, w]})) の重みを ((|weight|)) にします。
    
    辺 (({[v, w]})) が無ければ、作ります。
    
--- add_edge(v, w[, weight])
    
    (({self[v, w]= weight})) と同じです。 ((|weight|))
    を省略すると (({1})) になります。
    
--- delete_edge(v, w)
    
    辺 (({[v, w]})) を削除します。
    
--- add_vertex(v)
    
    頂点 ((|v|)) を追加します。
    
--- delete_vertex(v)
    
    頂点 ((|v|)) を削除します。
    
    ((|v|)) を始点や終点とする辺も削除します。
