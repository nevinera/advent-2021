class Problem02
  extend Memoist
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def answer
    increasing_pairs.count
  end

  private

  memoize def values
    Parser.new(path).numbers
  end

  memoize def smoothed_values
    SlidingWindow.new(values).window_sums(3)
  end

  memoize def increasing_pairs
    IncreaseFinder.new(smoothed_values).increasing_pairs
  end
end
