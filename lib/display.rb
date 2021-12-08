require "set"

class Display
  extend Memoist

  DIGITS = {
    "8" => [1, 2, 3, 4, 5, 6, 7], # 7
    "1" => [      3,       6   ], # 2
    "4" => [   2, 3, 4,    6   ], # 4
    "7" => [1,    3,       6   ], # 3
    "2" => [1,    3, 4, 5,    7], # 5
    "5" => [1, 2,    4,    6, 7], # 5
    "3" => [1,    3, 4,    6, 7], # 5
    "9" => [1, 2, 3, 4,    6, 7], # 6
    "0" => [1, 2, 3,    5, 6, 7], # 6
    "6" => [1, 2,    4, 5, 6, 7], # 6
    # cnts  8, 6, 8, 7, 4, 9, 7
    #       -  -        -  -
  }.freeze

  SEGMAP = {
    "a" => 1,
    "b" => 2,
    "c" => 3,
    "d" => 4,
    "e" => 5,
    "f" => 6,
    "g" => 7,
  }

  attr_reader :combos, :digits, :counts

  def initialize(n, combos, digits)
    @n = n
    @combos = combos.map { |c| c.chars.map { |ch| SEGMAP[ch] }.sort }
    @digits = digits.map { |d| d.chars.map { |ch| SEGMAP[ch] }.sort }
    @counts = (1..7).map { |x| [x, @combos.count { |combo| combo.include?(x) }] }.to_h
  end

  memoize def mapping
    combos_by_size = combos.group_by(&:length)

    m = {}    # maps a digit name to a combination of signal values
    s = {}    # maps a signal value to a real location in a digit (top to bottom, left to right)

    m["1"] = combos_by_size[2].first
    m["4"] = combos_by_size[4].first
    m["7"] = combos_by_size[3].first
    m["8"] = combos_by_size[7].first

    # "7" and "1" only differ by one segment, so we know which is the top segment
    s[1] = (m["7"] - m["1"]).first
    s[2] = (1..7).detect { |n| counts[n] == 6 }
    s[5] = (1..7).detect { |n| counts[n] == 4 }
    s[6] = (1..7).detect { |n| counts[n] == 9 }

    # only digit that doesn't include the bottom-right segment
    m["2"] = combos.detect { |c| !c.include?(s[6]) }

    # the remaining size-5 digits
    fives = combos_by_size[5]
    m["5"] = fives.detect { |c| c != m["2"] && c.include?(s[2]) }
    m["3"] = (fives - [m["2"], m["5"]]).first

    sixes = combos_by_size[6]
    m["9"] = sixes.detect { |c| !c.include?(s[5]) }

    s[3] = (m["3"] - m["5"]).first
    m["6"] = sixes.detect { |c| !c.include?(s[3]) }
    m["0"] = (combos - m.values).first

    m
  end

  memoize def digit_mapping
    mapping.invert
  end

  def digit_values
    digits.map { |d| digit_mapping[d] }
  end

  def value
    digit_values.join.to_i
  end
end
