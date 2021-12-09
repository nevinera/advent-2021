class Lava
  extend Memoist
  attr_reader :text

  def initialize(text)
    @text = text
  end

  memoize def grid
    values = text.split("\n").map(&:strip).map(&:chars)

    {}.tap do |entries|
      values.each_with_index do |row, y|
        row.each_with_index do |val, x|
          entries[[x, y]] = val.to_i
        end
      end
    end
  end

  def adjacencies(x, y)
    [[x, y - 1], [x, y + 1], [x - 1, y], [x + 1, y]]
  end

  def low_point?(x, y)
    grid[[x, y]] < grid.values_at(*adjacencies(x, y)).compact.min
  end

  memoize def low_points
    grid.keys.select { |x, y| low_point?(x, y) }
  end

  memoize def low_point_risk_score_total
    low_points.map { |x, y| grid[[x, y]] + 1 }.sum
  end

  memoize def flows
    edges = {}
    grid.keys.each do |x, y|
      if grid[[x, y]] < 9 && !low_point?(x, y)
        lowest = adjacencies(x, y).map { |j, k| grid[[j, k]] }.compact.min
        target = adjacencies(x, y).detect { |j, k| grid[[j, k]] == lowest }
        edges[[x, y]] = target
      end
    end
    edges
  end

  memoize def basins
    low_points.map { |lp| basin_for(lp) }
  end

  def largest_basin_sizes
    basins.map(&:size).sort.last(3)
  end

  def basin_size_product
    largest_basin_sizes.reduce(&:*)
  end

  def expand_basin(basin)
    additional = flows.select do |from, to|
      basin.include?(to) && !basin.include?(from)
    end

    basin.union(additional.map(&:first).to_set)
  end

  memoize def basin_for(pair)
    basin = [pair].to_set

    loop do
      new_basin = expand_basin(basin)
      return basin if new_basin == basin
      basin = new_basin
    end
  end
end
