class Parser
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def lines
    @_lines ||= content.split("\n").reject { |ln| ln.empty? }.map(&:strip)
  end

  def comma_separated_numbers
    content.split(/[,\n]+/).map(&:strip).reject(&:empty?).map(&:to_i)
  end

  def numbers
    @_numbers ||= lines.map(&:strip).map(&:to_i)
  end

  def movements
    lines.map do |line|
      dir, dist_string = line.strip.split(/\s+/).map(&:strip)
      [dir, dist_string.to_i]
    end
  end

  def bingo
    calls = lines.shift.split(",").map(&:to_i)
    boards = []
    boards << read_board(lines) while lines.any?
    [calls, boards]
  end

  def segments
    lines.map do |line|
      pairs = line.split(/\s+->\s+/)
      points = pairs
        .map { |pair| pair.split(",").map(&:strip).map(&:to_i) }
        .map { |x, y| Point.new(x, y) }
      Segment.new(*points)
    end
  end

  def displays
    lines.map do |line|
      combos_s, digits_s = line.split(" | ")
      [
        combos_s.split(" "),
        digits_s.split(" "),
      ]
    end
  end

  private

  def content
    @_content ||= File.read(path)
  end

  def read_board(lines)
    # read five lines with five values each
    board_lines = lines.shift(5)
    board_lines.map do |line|
      line.strip.split(/\s+/).map(&:to_i)
    end
  end
end
