class Target
  extend Memoist

  def initialize(text)
    @text = text
  end

  memoize def target_ranges
    @text =~ /^target area: x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)$/
    [($1.to_i .. $2.to_i), ($3.to_i .. $4.to_i)]
  end

  memoize def target_x
    target_ranges.first
  end

  memoize def target_y
    target_ranges.last
  end

  def hit?(x, y)
    px, py = 0, 0
    vx, vy = x, y

    1000.times do |t|
      px += vx
      py += vy
      vx = toward_zero(vx)
      vy -= 1

      # puts "  -> (#{px}, #{py})   v = [#{vx}, #{vy}]"

      if target_x.include?(px) && target_y.include?(py)
        return true
      elsif px > target_x.end || py < target_y.begin
        return false
      elsif px < target_x.begin && vx <= 0
        return false
      end
    end

    fail("1000 times wasn't enough?")
  end

  def toward_zero(n)
    if n > 0
      n - 1
    elsif n < 0
      n + 1
    else
      n
    end
  end
end
