# -*- coding: utf-8 -*-

require "pp"

class DirectedGraph
    attr_reader :nodes
    attr_reader :weights
    attr_reader :edges
    attr_reader :flow
    def initialize # initialization
        @nodes = []
        @edges = Hash.new{|h,k| h[k] = []}
        @weights = Hash.new{|h,k| h[k] = {}} 
        @flow = Hash.new{|h,k| h[k] = {}} 
    end

    def add_node(v)
        @nodes.push v unless @nodes.include?(v)
    end

    def add_edge(u, v)
        add_node(u)
        add_node(v)
        unless @edges[u].index(v)
            @edges[u].push v
        end
    end

    def [](u, v)
        @weights[{u => v}]
    end

    def []=(u, v, w, f = 0) 
        add_node(u)
        add_node(v)
        add_edge(u, v)
        @weights[{u => v}] = w
        @flow[{u => v}] = f
    end

    def residual_network # グラフに対する残余ネットワーク
        g = DirectedGraph.new
        self.nodes.each{|u|
            self.nodes.each{|v|
                if self.edges[u].include?(v) # (u, v) \in Vかどうか
                    if self.flow[{u => v}] == 0 
                        g[u, v] = self.weights[{u => v}] 
                    elsif self.weights[{u => v}] > self.flow[{u => v}]
                        g[v, u] = self.flow[{u => v}]
                        g[u, v] = self.weights[{u => v}] - self.flow[{u => v}]
                    elsif self.weights[{u => v}] > self.flow[{u => v}]
                        g[v, u] = self.flow[{u => v}] 
                    else
                    end        
                end
            }
        }
        return g
    end

    def ford_fulkerson(s ,t)
        # 初期化
        f = Hash.new{|h,k| h[k] = {}}
        self.edges.each_pair{|u, nodes| 
            nodes.each{|v|
                f[{u => v}] = 0; f[{v => u}] = 0
            }
        }
        residual_network = self.residual_network
        r = route(residual_network.bfs(s), s, t) # 残余ネットワークにおいて、sからtへの経路を計算
        min_flow =  r.enum_cons(2).map{|edge| # 残余ネットワークにおけるsからtへの経路の中で最小の容量を求める
            u = edge[0]; v = edge[1]
            residual_network[u, v]
        }.min
        while reachable?(r, s, t) # 残余ネットワークにおいて増加道がある限り繰り返す
            r.enum_cons(2).each{|edges|
                u = edges[0]; v = edges[1]
                if self[u, v] <= min_flow + self.flow[{u => v}] # 容量を越えたら、フローを容量にする
                    self[u, v, self[u, v]] = self[u, v]
                else # フローがまだ増やせるんだったら、今のフローに足し込む
                    self[u, v, self[u, v]] = self.flow[{u => v}] + min_flow
                end
            }
            residual_network = self.residual_network
            r = route(residual_network.bfs(s), s, t) # 残余ネットワークにおいて、sからtへの経路を計算
            min_flow =  r.enum_cons(2).map{|edge| # 残余ネットワークにおけるsからtへの経路の中で最小の容量を求める
                u = edge[0]; v = edge[1]
                residual_network[u, v]
            }.min
        end
        return self
    end

    def bfs(s) # 幅優先探索。頂点をkeyに、そのparentをvalueにしたハッシュであるpiを返す
        pi = {} # 親の情報を格納
        next_sources = [] # 次の始点となる頂点集合
        q = self.nodes.clone - [s] # 探索されていないもの
        edges = self.edges[s]
        edges.each{|v|
            next_sources.push v
            pi[v] = s
            q -= [v]
        }
        while !q.empty? # Queueが空になるまで繰り返す
            tmp = []
            next_sources.each{|s|
                edges = self.edges[s].reject{|x| # すでに探索されたものは除去
                    (pi.keys | pi.values).uniq.include?(x)
                } 
                edges.each{|v|
                    tmp.push v
                    pi[v] = s
                    q -= [v]
                }
            }
            next_sources.clear
            next_sources = tmp
            break if next_sources.empty?
        end
        return pi
    end

    def route(pi, s, t) # sからtへの経路を返す。途中で行けなくなる場合は、行けたところまでの経路を返す
        r = [t]
        while !r.include?(pi[t]) && # また来たことがない
            pi[t] !=s && # 残余ネットワークにおいてはsから出ていく場合がある 
            !pi[t].nil? # 親がいない場合
            r.push pi[t]
            t = pi[t] # 親をたどっていかせる
        end
        r.push s if pi[t] == s # 最後の親がsかどうか
        return r.reverse
    end

    def reachable?(route, s, t) # 経路routeを使って、sからtへ到達可能かどうか
        (route[0] == s) && (route[route.length-1] == t)
    end
end
__END__
g = DirectedGraph.new

g["s", "v1"] = 16
g["s", "v2"] = 13
g["v1", "v2"] = 10
g["v2", "v1"] = 4
g["v1", "v3"] = 12
g["v2", "v4"] = 14
g["v3", "v2"] = 9
g["v3", "t"] = 20
g["v4", "v3"] = 7
g["v4", "t"] = 4

pp g.ford_fulkerson("s", "t")
