require "memoist"

class Problem01
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

  memoize def increasing_pairs
    IncreaseFinder.new(values).increasing_pairs
  end
end
