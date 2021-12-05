class VentField
  attr_reader :segments, :magnitudes

  def initialize
    @segments = []
    @magnitudes = {}
  end

  def add_segment(segment)
    @segments << segment
    segment.crossed_points.each do |p|
      @magnitudes[p.coords] ||= 0
      @magnitudes[p.coords] += 1
    end
  end

  def magnitude_grid
    endpoints = segments.map(&:a) + segments.map(&:b)
    min_x, max_x = endpoints.map(&:x).then { |all_x| [all_x.min, all_x.max] }
    min_y, max_y = endpoints.map(&:y).then { |all_y| [all_y.min, all_y.max] }

    (min_y..max_y).map do |y|
      (min_x..max_x).map do |x|
        magnitude = magnitudes[[x, y]]
        magnitude ? magnitude.to_i : "."
      end.join
    end.join("\n") + "\n"
  end
end
