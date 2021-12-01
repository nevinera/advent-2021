require_relative "./parser"
require_relative "./sliding_window"

class IncreaseFinder
  attr_reader :values

  def initialize(values)
    @values = values
  end

  def increasing_pairs
    pairs.select { |a, b| b > a }
  end

  private

  def pairs
    SlidingWindow.new(values).windows(2)
  end
end
