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

            h = 0
            mz = []
            while line = f.gets
                mz[h] = line.chomp!.unpack("C*")
                h+=1
            end
            _parse_maze(mz)
        end
    end

    def out_of_range?(x, y)
        puts "OOR:#{x},#{y}" if $DEBUG
        if x < 0 or (x > @width)
            puts "x is #{x} but width is #{@width}" if $DEBUG
            return :x_oor
        end
        if y < 0 or (y > @height)
            puts "y is #{y} but height is #{@height}" if $DEBUG
            return :y_oor
        end
        false
    end
    alias oor? out_of_range?


    def [](x, y)
        @maze[y][x]
    end

    def wall?(x,y)
        (@maze[y][x] == :wall)
    end

    def dot?(x,y)
        @maze[y][x] == :dot
    end
    
    def eated?(x,y)
        @maze[y][x] == :eated
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

    def cango?(now, vec)
        ox, oy = now
        vx, vy = vec
        gx = ox + vx
        gy = oy + vy

        # Range check
        return false if out_of_range?(gx, gy)
        # Wall
        return false if wall?(gx, gy)
        # Enemy is there?
        return falase if enemy?(gx, gy)
        # Otherwise
        return true
    end

    def showmaze
        puts "T:#{@times+1} W:#{@width} H:#{@height}"
        maze = Array.new
        @height.times do |y|
            maze[y] = Array.new
            @width.times do |x|
#                puts "#{x},#{y}=#{@maze[y][x]}" if $DEBUG
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
    end

    def _parse_maze(maze)
#        pp maze
        @height.times do |y|
            @maze[y] = Array.new
            @width.times do |x|
#                puts "#{x},#{y}=#{maze[y][x].chr}" if $DEBUG
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
                    @maze[y][x] = :dot
                    @objects.push Enemy.new(x, y, 'V')
                when 'H'
                    @maze[y][x] = :dot
                    @objects.push Enemy.new(x, y, 'H')
                when 'L'
                    @maze[y][x] = :dot
                    @objects.push Enemy.new(x, y, 'L')
                when 'R'
                    @maze[y][x] = :dot
                    @objects.push Enemy.new(x, y, 'R')
                when 'J'
                    @maze[y][x] = :dot
                    @objects.push Enemy.new(x, y, 'J')
                else
                    raise
                end
            end
        end
    end

    attr_reader :time, :maze, :width, :height
end

#__END__
mz = Maze.new(ARGV.shift)
mz.showmaze

#pp mz.wall?(0,0)
#pp mz.wall?(1,1)
pp mz.oor?(mz.height,mz.width)
pp mz.oor?(mz.height-1,mz.width-1)
pp mz.oor?(mz.height-2,mz.width-2)
#pp mz.oor?(-1,0)
#pp mz.oor?(0,-1)
#pp mz.oor?(0,0)
#pp mz.oor?(1,1)
#pp mz.dot?(1,1)
#pp mz.dot?(0,0)
#pp mz.eated?(1,1)
#pp mz.eated?(0,0)
#pp mz.enemy?(2,1)
#pp mz.enemy?(8,1)
#pp mz.enemy?(1,3)
#pp mz.enemy?(5,5)
#mz.go(['h', 'j', 'k', 'l'])
