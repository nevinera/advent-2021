class Problem07
  extend Memoist
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def answer
    winner.score
  end

  memoize def winner
    game.winner(calls)
  end

  memoize def boards
    parsed.last.map { |board_data| BingoBoard.new(board_data) }
  end

  private

  def game
    BingoGame.new(boards)
  end

  def parsed
    Parser.new(path).bingo
  end

  def calls
    parsed.first
  end
end
