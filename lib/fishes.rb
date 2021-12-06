class Fishes
  attr_reader :totals, :elapsed

  def initialize(timers)
    @totals = [0] * 10
    @elapsed = 0
    timers.each { |t| totals[t] += 1 }
  end

  def wait(n)
    n.times { step }
  end

  def step
    new_parents = totals[0]
    (1..9).each { |n| totals[n - 1] = totals[n] }
    totals[6] += new_parents
    totals[8] += new_parents
    @elapsed += 1
  end

  def count
    totals.sum
  end
end
