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

  def crossed_points
    fail(ArgumentError, "Orthonormal segments only, for now") unless orthonormal?

    # these describe a *box*, but for orthonormal segments the box is always the segment itself.
    xrange = Range.new(*[a.x, b.x].sort)
    yrange = Range.new(*[a.y, b.y].sort)

    [].tap do |pairs|
      xrange.each do |xval|
        yrange.each do |yval|
          pairs << Point.new(xval, yval)
        end
      end
    end
  end
end
