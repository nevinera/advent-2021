class Problem09
  extend Memoist
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def answer
    vent_field.magnitudes.values.select { |v| v > 1 }.length
  end

  def grid
    vent_field.magnitude_grid
  end

  private

  memoize def segments
    Parser.new(path).segments
  end

  memoize def orthonormal_segments
    segments.select(&:orthonormal?)
  end

  memoize def vent_field
    VentField.new.tap do |field|
      orthonormal_segments.each do |segment|
        field.add_segment(segment)
      end
    end
  end
end
