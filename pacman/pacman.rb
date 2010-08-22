# coding:utf-8
# vim:ts=2 sw=2 sts=0
require 'pp'

class Maze
  class MazeObject
    def initialize(x,y, character)
      @x = x
      @y = y
      @ch = character
    end
    def to_c
      @ch
    end
    def pos
      [@x, @y]
    end
  end

  class Enemy < MazeObject
    def step(pcx, pcy)
      compute(pcx, pcy)
    end

    def compute(pcx, pcy)
      # Each Enemy AI here. Compute which direction the enemy move to.
    end
  end

  class PacMan < MazeObject
    # return vec
    def go(direction)
      case direction
      when 'h'
        [-1, 0]
      when 'j'
        [0, 1]
      when 'k'
        [0, -1]
      when 'l'
        [0, 1]
      end
    end
  end

=begin

Maze construct.
    # = :wall, ' ' = space. It work as same as wall. So it make wall.
    . = :dot or :eated is defined for flag.
    @ = :pacman pacman is now there
    VHLRJ = :enemy and so on.

TODO: Now all of enemys are :enemy.
=end
  def initialize(filename)
    @objects = Array.new

    File.open(filename) do |f|
      @times = f.gets
      @width, @height = f.gets.split

      @times = @times.to_i-1
      @width = @width.to_i
      @height = @height.to_i
      @maze = Array.new(@height)
      @crosses = Array.new
      @roads = Array.new
      @deadends = Array.new


      h = 0
      mz = []
      while line = f.gets
        mz[h] = line.chomp!.unpack("C*")
        h+=1
      end
      _parse_maze(mz)
      _parse_crosses
      _parse_roads
      _parse_deadends
    end
  end

  def showmaze
    puts "T:#{@times+1} W:#{@width} H:#{@height}"
    maze = Array.new
    @height.times do |y|
      maze[y] = Array.new
      @width.times do |x|
#        puts "#{x},#{y}=#{@maze[y][x]}" if $DEBUG
        case @maze[y][x]
        when :wall
          maze[y][x] = '#'
        when :dot
          maze[y][x] = '.'
        end
      end
    end
    @objects.each do |o|
      ox, oy = o.pos
      maze[oy][ox] = o.to_c
    end
    @height.times do |y|
      @width.times do |x|
        print maze[y][x]
      end
      puts
    end
    puts "crosses:#{@crosses.size} roads:#{@roads.size} deadends:#{@deadends.size}"
  end

  def _parse_maze(maze)
#    pp maze
    @height.times do |y|
      @maze[y] = Array.new
      @width.times do |x|
#        puts "#{x},#{y}=#{maze[y][x].chr}" if $DEBUG
        case maze[y][x].chr
        when '#'
          @maze[y][x] = :wall
        when ' '
          @maze[y][x] = :wall
        when '.'
          @maze[y][x] = :dot
        when '@'
          @maze[y][x] = :dot
          @objects.push PacMan.new(x, y, '@')
        when 'V'
          @maze[y][x] = :eated
          @objects.push Enemy.new(x, y, 'V')
        when 'H'
          @maze[y][x] = :eated
          @objects.push Enemy.new(x, y, 'H')
        when 'L'
          @maze[y][x] = :eated
          @objects.push Enemy.new(x, y, 'L')
        when 'R'
          @maze[y][x] = :eated
          @objects.push Enemy.new(x, y, 'R')
        when 'J'
          @maze[y][x] = :eated
          @objects.push Enemy.new(x, y, 'J')
        else
          raise
        end
      end
    end
  end

  def walk(&block)
    @height.times do |y|
      @width.times do |x|
#        puts "WALKING(#{y},#{x}) ==========>" if $DEBUG
        block.call(x,y)
      end
    end
  end


  def out_of_range?(x, y)
    #        puts "OOR:#{x},#{y}" if $DEBUG
    if x < 0 or (x >= @width)
#      puts "x is #{x} but width is #{@width}" if $DEBUG
      return :x_oor
    end
    if y < 0 or (y >= @height)
#      puts "y is #{y} but height is #{@height}" if $DEBUG
      return :y_oor
    end
    false
  end
  alias oor? out_of_range?

  def cell(x, y)
    @maze[y][x]
  end

  def is(x,y)
#    puts "IS?:#{x},#{y}" if $DEBUG
    return nil if oor?(x,y)
    cell(x,y)
  end

  def wall?(x,y)
    # Out of range is as same as wall.
    if oor?(x,y)
      return false
    end
    # check the cell is wall or not
#    puts "WALL?:#{x},#{y}=#{is(x,y)}" if $DEBUG
    if is(x,y) == :wall
      return :wall
    end
    false
  end

  def dot?(x,y)
    is(x,y) == :dot
  end

  def eated?(x,y)
    is(x,y) == :eated
  end

  def enemy?(x,y)
    @objects.each do |o|
      ox, oy = o.pos
      if ox == x && oy == y then
        return true
      end
    end
    false
  end

  def _dir(vec)
    return 0 if vec == [ 0, -1]
    return 1 if vec == [ 0, 1]
    return 2 if vec == [-1, 0]
    return 3 if vec == [ 1, 0]
    return -1 if vec == [ 0, 0]
    raise
  end

  def cango?(now, vec)
    ox, oy = now
    vx, vy = vec
    gx = ox + vx
    gy = oy + vy
    # Otherwise
    cango = true

    # Range check
    cango = false if out_of_range?(ox, oy)
    cango = false if out_of_range?(gx, gy)
    # Wall
    cango = false if wall?(gx, gy)
    # Enemy is there?
    cango = false if enemy?(gx, gy)
    cango
  end

  def ways(pos)
    x, y = pos
    if oor?(x, y)
      return nil
    else
      return [
        cango?([x,y],[ 0,-1]),  # UP
        cango?([x,y],[ 0, 1]),  # DOWN
        cango?([x,y],[-1, 0]),  # LEFT
        cango?([x,y],[ 1, 0])   # RIGHT
      ]
    end
  end

  def _number_of_ways(numways, pos)
    return nil unless dot?(pos[0], pos[1])
    around = ways(pos)
    return false if around.nil?
    count = 0
    around.map {|p| count+=1 if p}
    count >= numways ? around : nil
  end

  def cross?(pos)
    _number_of_ways(3, pos)
  end
  def road?(pos)
    _number_of_ways(2, pos)
  end
  def deadend?(pos)
    _number_of_ways(1, pos)
  end

  def _parse_crosses
    walk {|x,y|
      a = cross?([x,y])
      if a then
#        print "CROSS(#{x},#{y},#{is(x,y)})" ; pp a
        @crosses.push [x,y]
      end
    }
  end

  def _parse_roads
    walk {|x,y|
      a = road?([x,y])
      if a then
#        print "ROAD(#{x},#{y},#{is(x,y)})" ; pp a
        @roads.push [x,y]
      end
    }
  end

  # mmm, initial enamies position should be considerd...
  def _parse_deadends
    walk {|x,y|
      a = deadend?([x,y])
      if a then
#        print "DEADEND(#{x},#{y},#{is(x,y)})" ; pp a
        @deadends.push [x,y]
      end
    }
  end
  attr_reader :time, :maze, :width, :height, :crosses, :roads, :deadends, :cango
end

#__END__
mz = Maze.new(ARGV.shift)
mz.showmaze

#pp mz.wall?(0,0)
#pp mz.wall?(1,1)
=begin
pp mz.oor?(mz.height+1,mz.width+1)
pp mz.oor?(mz.height,mz.width)
pp mz.oor?(-1,0)
pp mz.oor?(0,-1)
pp mz.oor?(0,0)
pp mz.oor?(1,1)
pp mz.dot?(1,1)
=end
#pp mz.dot?(0,0)
#pp mz.eated?(1,1)
#pp mz.eated?(0,0)
#pp mz.enemy?(2,1)
#pp mz.enemy?(8,1)
#pp mz.enemy?(1,3)
#pp mz.enemy?(5,5)
=begin
pp mz[0,0]
pp mz.cango?([0,0],[0,1])
pp mz[1,1]
pp mz.cango?([1,1],[0,-1]) # UP
pp mz.cango?([1,1],[0,1])  # DOWN
pp mz.cango?([1,1],[-1,0]) # LEFT
pp mz.cango?([1,1],[1,0])  # RIGHT
pp mz.ways([1,1])
pp mz.ways([5,2])
pp mz.ways([5,5])
pp mz.ways([100,5])
pp mz.ways([1,110])
=end

#pp mz
#mz.go(['h', 'j', 'k', 'l'])

