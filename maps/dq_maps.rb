#!/usr/bin/env ruby
# 
# devquiz graph search / maps API
#
require 'gmap_direction'
require 'pp'

class DevquizMapSearch

    DATADIR = "./data/"

    def initialize(filename)
        @pfile = filename
        @names = Array.new
        @list  = Array.new
        @distances = Array.new

        File.open(DATADIR + @pfile, 'r') do |f|
            count = 0
            while line = f.gets
                fields = line.chomp!.split
                next if fields.size != 3
                @names[count] = fields[0]
                @list[count] = "#{fields[1]},#{fields[2]}"
                count+=1
            end
        end
        update_distances
    end

    def update_distances
        distance_file = "d#{@pfile}"
        distance_file_path = DATADIR + distance_file

        if File.exists?(distance_file_path) then
            load_cache(distance_file_path)
        else
            measure_distance(distance_file_path)
        end
    end

    def load_cache(cachepath)
        puts "Load cache. #{cachepath}"
        i = 0
        File.open(cachepath, "r") do |f|
            count = f.gets.to_i
            count.times do |i|
                @distances[i] = Array.new(count)
            end

            while line = f.gets
                org, dst, r = line.chomp!.split(/,/)
                @distances[org.to_i][dst.to_i] = r.to_i
                i+=1
            end
        end
        pp @distances if $DEBUG
    end

    def measure_distance(cachepath)
        puts "cache is not there. create now."
        count = @list.size
        File.open(cachepath, "w") do |f|
            f.puts count
            count.times do |i|
                @distances[i]=Array.new
                count.times do |j|
                    next if i == j
                    d = Array.new
                    r = get_seconds(i, j)
                    f.puts "#{i},#{j},#{r}" if $DEBUG
                    @distances[i][j] = r.to_i
                end
            end
        end
    end

    def get_seconds(i, j)
        r = GMapDirection.new(@list[i], @list[j]).range
#        r = rand(100)
    end

    def costf(sol)
        print "costf:" if $DEBUG
        pp sol if $DEBUG
        cost = 0
        sol.inject {|x,y|
            print "#{x},#{y}" if $DEBUG
            r = @distances[x][y]
            print "=#{r} " if $DEBUG
            cost += r
            y
        }
        cost
    end

    def create_solution(min, max)
        sol = Array.new
        min.upto(max-1) do |i|
            sol.push i
        end
        sol = sol.sort_by{rand}
        sol
    end

    def random_optimize(num)
        best = 99999999
        bestpath = nil
        sol = [0] + create_solution(1, @list.size) + [0]
        num.times do |n|
            sol = [0] + create_solution(1, @list.size) + [0]
            score= costf(sol)
            if score < best
                best = score
                bestpath = sol
            end
            puts if $DEBUG
        end
        [bestpath, best]
    end

=begin
    def hillclimb_optimize
        loop do
            neighbors = []
            sol = create_solution(0, @list.size)
            count = @list.size
            p "count:#{count}"
            count.times do |i|
                p "i:#{i}"
                value = sol[i] 
                if (value-1) > 0 then
                    newsol = sol.dup
                    newsol[i] = (value-1)
                    neighbors.push newsol
                end
                if (value+1) < count then
                    newsol = sol.dup
                    newsol[i] = (value+1)
                    neighbors.push newsol
                end
            end
            pp neighbors
            best = costf(sol)
            bestpath = sol
            neighbors.each do |ns|
                score= costf(ns)
                if score > best
                    best = score
                    bestpath = ns
                end
                puts if $DEBUG
            end
            break  if bestpath == sol
        end
        [bestpath, best]
    end
=end


    attr_reader :list, :names, :distances
end


dqm = DevquizMapSearch.new(ARGV.shift||"1.txt")
pp result = dqm.random_optimize(ARGV.shift.to_i||100)
result[0].each do |i|
    print "#{dqm.names[i]} "
end
puts
#pp dqm.hillclimb_optimize

