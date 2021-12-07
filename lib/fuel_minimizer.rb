class FuelMinimizer
  attr_reader :positions

  def initialize(positions)
    @positions = positions.sort
  end

  def minimal_total
    (positions.first .. positions.last).map { |x| total_distance_from(x) }.min
  end

  def minimal_fuel_total
    (positions.first .. positions.last).map { |x| total_fuel_from(x) }.min
  end

  def total_distance_from(x)
    positions.map { |p| (x - p).abs }.sum
  end

  def total_fuel_from(x)
    positions
      .map { |p| (x - p).abs }
      .map { |d| d * (d + 1) / 2 }
      .sum
  end
end
