require_relative "./parser"

class IncreaseFinder
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def values
    @_values ||= Parser.new(path).numbers
  end

  def count
    @_count ||= values.length
  end

  def sliding_window(array, window_size)
    (0 .. (array.length - window_size)).map do |offset|
      array.slice(offset, window_size)
    end
  end

  def sliding_sums(window_size)
    sliding_window(values, window_size).map(&:sum)
  end

  # Problem 1 -------

  def pairs
    @pairs ||= sliding_window(values, 2)
  end

  def increasing_pairs
    @_increasing_pairs ||= pairs.select { |a, b| b > a }
  end

  def increase_count
    increasing_pairs.length
  end

  # Problem 2 --------

  def window_pairs
    sliding_window(sliding_sums(3), 2)
  end

  def increasing_sums
    window_pairs.select { |a, b| b > a }
  end

  def increasing_sum_count
    increasing_sums.count
  end
end
