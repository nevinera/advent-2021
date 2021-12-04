class BingoBoard
  attr_reader :values, :marked

  # all the sets of points that represent a winning line, if filled
  LINES = [
    # diagonls
    (0..4).zip(0..4),
    (0..4).to_a.reverse.zip(0..4),

    # columns
    (0..4).map { |n| [n, 0] },
    (0..4).map { |n| [n, 1] },
    (0..4).map { |n| [n, 2] },
    (0..4).map { |n| [n, 3] },
    (0..4).map { |n| [n, 4] },

    # rows
    (0..4).map { |n| [0, n] },
    (0..4).map { |n| [1, n] },
    (0..4).map { |n| [2, n] },
    (0..4).map { |n| [3, n] },
    (0..4).map { |n| [4, n] },
  ].freeze

  def initialize(rows)
    @values = {}
    @marked = {}

    rows.each_with_index do |row, row_number|
      row.each_with_index do |value, col_number|
        @values[[row_number, col_number]] = value
      end
    end
  end

  def value(row, col)
    @values[[row, col]]
  end

  def mark(value)
    @values.each_pair do |coords, board_value|
      @marked[coords] = true if board_value == value
    end
  end

  def marked?(row, col)
    @marked.fetch([row, col], false)
  end

  def complete?
    LINES.each do |coords|
      return true if coords.all? { |row, col| marked?(row, col) }
    end
    false
  end
end
