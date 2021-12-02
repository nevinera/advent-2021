require "memoist"

class Problem03
  extend Memoist
  attr_reader :path, :position

  def initialize(path)
    @path = path
    @position = Position.new
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
