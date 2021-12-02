class AimedPosition
  attr_accessor :aim, :depth, :horizontal

  def initialize(aim: 0, depth: 0, horizontal: 0)
    @aim, @depth, @horizontal = aim, depth, horizontal
  end

  def move(direction, distance)
    case direction.to_sym
    when :forward
      @horizontal += distance
      @depth += (aim * distance)
    when :up
      @aim -= distance
    when :down
      @aim += distance
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
