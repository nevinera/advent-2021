class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def coords
    [x, y]
  end

  def ==(other)
    other.x == x && other.y == y
  end

  def inspect
    "Point(#{x},#{y})"
  end
end
