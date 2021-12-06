class Problem12
  extend Memoist
  attr_reader :path

  PERIOD = 256

  def initialize(path)
    @path = path
  end

  def answer
    fishes.tap { |f| f.wait(PERIOD) }.count
  end

  private

  memoize def fishes
    Fishes.new(initial_timers)
  end

  def initial_timers
    Parser.new(path).comma_separated_numbers
  end
end

