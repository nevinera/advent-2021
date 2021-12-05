class Segment
  attr_reader :a, :b

  def self.from_coordinates(x1, y1, x2, y2)
    new(Point.new(x1, y1), Point.new(x2, y2))
  end

  def initialize(point_a, point_b)
    @a, @b = point_a, point_b
  end

  def orthonormal?
    a.x == b.x || a.y == b.y
  end

  def diagonal?
    (a.x - b.x).abs == (a.y - b.y).abs
  end

  def crossed_points
    fail(ArgumentError, "unsupported segment") unless orthonormal? || diagonal?

    if a.x == b.x
      birange(a.y, b.y).map { |y| Point.new(a.x, y) }
    elsif a.y == b.y
      birange(a.x, b.x).map { |x| Point.new(x, a.y) }
    else
      birange(a.x, b.x).zip(birange(a.y, b.y)).map { |x, y| Point.new(x, y) }
    end
  end

  def ==(other)
    (a == other.a && b == other.b) || (a == other.b && b == other.a)
  end

  def inspect
    "Segment{(#{a.x},#{a.y}) -> (#{b.x},#{b.y})}"
  end

  private

  # Ranges don't support decreasing values, so this lets us not worry about which order our
  # indices are in. (We don't mind concretizing our Ranges)
  def birange(i, j)
    if i <= j
      (i .. j).to_a
    else
      (j .. i).to_a.reverse
    end
  end
end
