#!/usr/bin/env ruby
# 
# devquiz graph search / maps API
#
require 'gmap_direction'
require 'directed_graph'
#require 'dfs'

=begin
class Array
    def combination(num)
        return [] if num < 1 || num > size
        return map{|e| [e] } if num == 1
        tmp = self.dup
        self[0, size - (num - 1)].inject([]) do |ret, e|
            tmp.shift
            ret += tmp.combination(num - 1).map{|a| a.unshift(e) }
        end
    end

    def product(other)
        inject([]) do |ret, es|
            ret += other.map{|eo| [es, eo]}
        end
    end
end

class GPoint
    def initialize(name, lat, lng)
        @name = name
        @lat = lat
        @lng = lng
        @ranges = Hash.new
    end
    attr_reader :name, :lat, :lng

    def to_s
        "#{lat},#{lng}"
    end

    def range(dest)
        @ranges[dest] if @ranges[dest]
        @ranges[dest] = get_range(dest)
        @ranges[dest]
    end

    def get_range(dest)
        raise TypeError, desr unless dest.is_a?(GPoint)
        r = GMapDirection.new(self.to_s, dest.to_s).range
        r
    end

end
=end

class DevQuizMaps
    def initialize(filename)
        @names = Array.new
        @list  = Array.new
        File.open(filename, 'r') do |f|
            count = 0
            while line = f.gets
                fields = line.chomp!.split
                next if fields.size != 3
                @names[count] = fields[0]
                @list[count] = "#{fields[1]},#{fields[2]}"
                count+=1
            end
        end
    end
    attr_reader :list, :names
end

def gmap_range(from, to)

end

g = DirectedGraph.new

dqm = DevQuizMaps.new(ARGV.shift||"1.txt")
count = dqm.list.size
count.times do |i|
    cache[i] = Hash.new
    count.times do |j|
        next if i == j
        r = GMapDirection.new(dqm.list[i], dqm.list[j]).range
        g[i, j] = = r
        puts "#{i}:#{dqm.names[i]},#{j}:#{dqm.names[j]},#{r}"
    end
end
count.times. do |c|
    puts "----- FF (0, #{c}) -----"
    pp g.ford_fulkerson(0,c)
end

