class IncreaseFinder
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def text
    @_text ||= File.read(path)
  end

  def values
    @_values ||= text.split("\n").map(&:strip).map(&:to_i)
  end

  def count
    @_count ||= values.length
  end

  def pairs
    @_pairs ||= (1...count).map do |n|
      from_value = values[n - 1]
      to_value = values[n]
      [from_value, to_value]
    end
  end

  def increasing_pairs
    @_increasing_pairs ||= pairs.select { |a, b| b > a }
  end

  def increase_count
    increasing_pairs.length
  end
end
