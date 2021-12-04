class Parser
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def lines
    @_lines ||= content.split("\n").reject { |ln| ln.empty? }.map(&:strip)
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
