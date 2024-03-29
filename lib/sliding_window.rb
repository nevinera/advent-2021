class SlidingWindow
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def windows(size)
    (0 .. (length - size)).map do |offset|
      array.slice(offset, size)
    end
  end

  def window_sums(size)
    windows(size).map(&:sum)
  end

  private

  def length
    array.length
  end
end
