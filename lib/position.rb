class Position
  attr_reader :depth, :horizontal

  def initialize
    @depth = 0
    @horizontal = 0
  end

  def move(direction, distance)
    case direction.to_sym
    when :forward
      @horizontal += distance
    when :up
      @depth -= distance
    when :down
      @depth += distance
    else
      fail(ArgumentError, "Move expects a direction of up, down, or forward")
    end
  end

  def move_all(pairs)
    pairs.each do |pair|
      move(*pair)
    end
  end
end
