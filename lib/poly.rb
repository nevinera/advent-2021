class Poly
  extend Memoist

  def initialize(text)
    @text = text
  end

  memoize def after(n)
    return initial_string if n <= 0
    transform(after(n - 1))
  end

  memoize def lines
    @text.split("\n")
  end

  memoize def initial_string
    lines.first.strip
  end

  memoize def rules
    lines.slice(2, lines.length).map do |rule_line|
      rule_line.split(" -> ").map(&:strip)
    end.to_h
  end

  def transform(s)
    s.chars.zip(insertions(s)).flatten.compact.join
  end

  def insertions(s)
    pairs(s).map do |pair|
      rules.fetch(pair, nil)
    end
  end

  def pairs(s)
    (0..(s.length - 2)).map do |offset|
      s.slice(offset, 2)
    end
  end
end
