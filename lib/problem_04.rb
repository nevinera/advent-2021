require "memoist"

class Problem04
  extend Memoist
  attr_reader :path, :position

  def initialize(path)
    @path = path
    @position = AimedPosition.new
  end

  def answer
    position.move_all(movements)
    position.depth * position.horizontal
  end

  private

  memoize def movements
    Parser.new(path).movements
  end
end
