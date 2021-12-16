class PathFinder
  extend Memoist
  attr_reader :text

  def initialize(text)
    @text = text
  end

  memoize def initial
    lines = @text.split("\n").map(&:strip)
    values = lines.map { |line| line.chars.map(&:to_i) }

    h = {}
    values.each_with_index do |row, y|
      row.each_with_index do |value, x|
        h[[x, y]] = value
      end
    end

    h[[0, 0]] = 0

    h
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


  def total
    fill = initial
    (1..10_000).each do |n|
      fill = reduce(fill)
      # print(n, fill)
      return n if fill[destination] == 0
    end
    fail "10,000 steps was not enough?"
  end

  def reduce(grid)
    next_grid = {}
    grid.each_pair do |coords, prior|
      if grid[coords].zero?
        next_grid[coords] = 0
      elsif adjacent_to_zero?(grid, coords)
        next_grid[coords] = grid[coords] - 1
      else
        next_grid[coords] = grid[coords]
      end
    end
    next_grid
  end

  def adjacent(pair)
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
