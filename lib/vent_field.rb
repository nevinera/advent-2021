class VentField
  attr_reader :segments, :magnitudes

  def initialize
    @segments = []
    @magnitudes = {}
  end

  def add_segment(segment)
    fail(ArgumentError, "Orthonormal segments only for now") unless segment.orthonormal?
    @segments << segment
    segment.crossed_points.each do |p|
      @magnitudes[p.coords] ||= 0
      @magnitudes[p.coords] += 1
    end
  end
end
