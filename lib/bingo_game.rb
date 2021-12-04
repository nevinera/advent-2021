class BingoGame
  attr_reader :boards

  def initialize(boards)
    @boards = boards
  end

  def winner(calls)
    calls.each do |value|
      boards.each { |board| board.mark(value) }

      winning_boards = boards.select(&:complete?)
      fail(ArgumentError, "Multiple winners") if winning_boards.length > 1

      if winning_boards.length == 1
        return winning_boards.first
      end
    end

    fail(ArgumentError, "No winner found")
  end
end
