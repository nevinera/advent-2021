class Poly
  extend Memoist

  def initialize(text)
    @text = text
  end

  memoize def lines
    @text.split("\n")
  end

  memoize def initial
    lines.first.strip.chars
  end

  memoize def rules
    lines.slice(2, lines.length).map do |rule_line|
      left, right = rule_line.split(" -> ").map(&:strip)
      [left.chars, right]
    end.to_h
  end

  memoize def counts_for(a, b, after)
    if after == 0 || !rules.include?([a, b])
      a == b ? {a => 2} : {a => 1, b => 1}
    elsif rules.include?([a, b])
      m = rules.fetch([a, b])
      lc = counts_for(a, m, after - 1)
      rc = counts_for(m, b, after - 1)
      count_merge(lc, rc, m)
    end
  end

  def count_merge(lc, rc, m)
    items = (lc.keys + rc.keys).uniq
    items.map do |item|
      total = lc.fetch(item, 0) + rc.fetch(item, 0)
      total -= 1 if item == m
      [item, total]
    end.to_h
  end

  memoize def after(n)
    s = initial
    offsets = (0..(s.length - 2)).to_a
    pairs = offsets.map { |offset| initial.slice(offset, 2) }

    counts = pairs.map { |a, b| counts_for(a, b, n) }

    count_sum = {}
    counts.each do |count|
      count.each_pair do |value, lc|
        count_sum[value] ||= 0
        count_sum[value] += lc
      end
    end

    double_counted = s.slice(1, s.length - 2)
    double_counted.each do |v|
      count_sum[v] -= 1
    end

    count_sum
  end
end
