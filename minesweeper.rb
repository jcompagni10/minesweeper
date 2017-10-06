require_relative "board"
class Minesweeper
  def initialize(size = 10)
    @board = Board.new(size)
  end

  def play
    until @board.won?
      move = get_move
      @board.make_move(move)
    end
    puts "You Win!!!"
  end

  def get_move
    "Move? (ex. 5,5)"
    parse_move(gets.chomp)
  end

  def parse_move(move)
    move.split(',')
  end

end
