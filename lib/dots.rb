class Dots
  extend Memoist

  def initialize(text)
    @text = text
  end

  memoize def pairs
    lines = @text.split("\n").grep(/,/)
    lines.map { |line| line.split(",").map(&:strip).map(&:to_i) }
  end

  FOLD_REGEX = /^fold along (?<dir>[xy])=(?<val>\d+)$/

  memoize def folds
    lines = @text.split("\n").grep(/fold/)
    lines.map do |line|
      matches = FOLD_REGEX.match(line)
      [matches.named_captures["dir"].to_sym, matches.named_captures["val"].to_i]
    end
  end

  def initial_grid
    pairs.to_set
  end

  def fold(dim, val, points)
    if dim == :y
      fold_y(val, points)
    else
      fold_x(val, points)
    end
  end

  def fold_y(val, points)
    stay_grid = points.select { |x, y| y < val }.to_set
    flip_grid = points.select { |x, y| y > val }.to_set
    flipped_grid = flip_grid.map { |x, y| [x, 2 * val - y] }.to_set
    stay_grid.union(flipped_grid)
  end

  def fold_x(val, points)
    stay_grid = points.select { |x, y| x < val }.to_set
    flip_grid = points.select { |x, y| x > val }.to_set
    flipped_grid = flip_grid.map { |x, y| [2 * val - x, y] }.to_set
    stay_grid.union(flipped_grid)
  end

  def print(set)
    max_x = set.map(&:first).max
    max_y = set.map(&:last).max

    puts (0..max_x).map { "=" }.join
    (0..max_y).each do |y|
      row = (0..max_x).map { |x| set.include?([x, y]) ? "#" : "." }.join
      puts row
    end
    puts (0..max_x).map { "=" }.join
    puts "\n"
  end
end
