class Problem11
  extend Memoist
  attr_reader :path, :period

  def initialize(path, period = 80)
    @path, @period = path, period
  end

  def answer
    fishes.tap { |f| f.wait(period) }.count
  end

  private

  memoize def fishes
    Fishes.new(initial_timers)
  end

  def initial_timers
    Parser.new(path).comma_separated_numbers
  end
end

