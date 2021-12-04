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

  def loser(calls)
    remaining_boards = boards
    calls.each do |value|
      boards.each { |board| board.mark(value) }

      completed_boards = remaining_boards.select(&:complete?)
      remaining_boards -= completed_boards

      if remaining_boards.empty?
        if completed_boards.length > 1
          fail(ArgumentError, "Multiple losers")
        else
          return completed_boards.first
        end
      end
    end

    fail(ArgumentError, "No loser found")
  end
end
