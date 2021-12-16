class PathFinder
  extend Memoist
  attr_reader :text

  def initialize(text)
    @text = text
  end

  memoize def initial_single
    lines = @text.split("\n").map(&:strip)
    values = lines.map { |line| line.chars.map(&:to_i) }

    h = {}
    values.each_with_index do |row, y|
      row.each_with_index do |value, x|
        h[[x, y]] = value
      end
    end

    h
  end

  memoize def initial
    grid_offsets = []
    (0..4).each { |gx| (0..4).each { |gy| grid_offsets << [gx, gy] } }

    grids = grid_offsets.map { |gx, gy| shifted_grid(gx, gy) }
    h = grids.reduce(&:merge)

    h[[0, 0]] = 0

    h
  end

  def shifted_grid(gx, gy)
    additional = gx + gy
    width = initial_single.keys.map(&:first).max + 1
    height = initial_single.keys.map(&:last).max + 1

    initial_single.map do |pair, value|
      new_coords = [
        pair.first + (gx * width),
        pair.last + (gy * height),
      ]
      new_value = value + additional
      new_value -= 9 if new_value > 9
      [new_coords, new_value]
    end.to_h
  end

  memoize def starting_point
    [0, 0]
  end

  memoize def destination
    coords = initial.keys
    max_x = coords.map(&:first).max
    max_y = coords.map(&:last).max
    [max_x, max_y]
  end

  memoize def total_width
    destination.first
  end

  memoize def total_height
    destination.last
  end

  def total
    fill = initial
    (1..10_000).each do |n|
      if n % 10 == 0
        puts "\n\n\n\n\n"
        print(n, fill)
      end
      reduce(fill)
      # print(n, fill)
      return n if fill[destination] == 0
    end
    fail "10,000 steps was not enough?"
  end

  def reduce(grid)
    reduced = Set.new

    grid.each_pair do |coords, prior|
      reduced << coords if !grid[coords].zero? && adjacent_to_zero?(grid, coords)
    end

    reduced.each {|pair| grid[pair] -= 1 }
    grid
  end

  memoize def adjacent(pair)
    x, y = pair
    [
      [x-1, y],
      [x, y-1],
      [x, y+1],
      [x+1, y],
    ]
  end

  def adjacent_to_zero?(grid, coords)
    adjacent(coords).any? { |pair| grid[pair] == 0 }
  end

  def print(n, grid)
    coords = grid.keys
    max_x = coords.map(&:first).max
    max_y = coords.map(&:last).max

    puts "----------------- Step #{n} ---------------"
    (0..max_y).each do |y|
      puts (0..max_x).map { |x| grid[[x, y]].to_s }.join
    end
  end
end
