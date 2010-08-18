=begin

=graph.rb

グラフ理論のライブラリです。グラフを表すクラス/モジュールと、
グラフ用の各種アルゴリズムを提供します。

==使用例:

((<simple_example.rb|URL:simple_example.rb>)) を見てください。

==クラス/モジュール:

:((<DirectedHashGraph クラス|URL:DirectedHashGraph.html>))
  Hash を使って実装した、普通の有向グラフ。
:((<UndirectedHashGraph クラス|URL:UndirectedHashGraph.html>))
  Hash を使って実装した、普通の無向グラフ。
:((<Graph モジュール|URL:Graph.html>))
  グラフの基本的な操作を定義したモジュール。
:((<GraphAlgorithm モジュール|URL:GraphAlgorithm.html>))
  グラフ用の各種アルゴリズムを提供するモジュール。

==動作環境:

たぶんRuby 1.8以降。

Cygwin Ruby 1.8.1にて動作確認しました。

==置き場所/連絡先:

((<URL:http://gimite.ddo.jp/gimite/rubymess.htm>))

Gimite 市川 <((<gimite@mx12.freecom.ne.jp|URL:mailto:gimite@mx12.freecom.ne.jp>))>

==ライセンス:

Public Domainです。煮るなり焼くなりご自由に。

==更新履歴:

2004/11/27 Ver.0.2
*((<GraphAlgorithm|URL:GraphAlgorithm.html>))#graphviz_format 追加。
*((<DirectedHashGraph|URL:DirectedHashGraph.html>))
 と ((<UndirectedHashGraph|URL:UndirectedHashGraph.html>)) がMarshal可能に。
*((<英語版マニュアル|URL:index.en.html>))を作成。

2004/11/13 Ver.0.1
*β版公開。

=end
