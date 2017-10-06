require_relative "tile"
require "byebug"

class Board
  def initialize(size)
    @size = size
    @board = Array.new(size) { Array.new(size) { Tile.new } }
    generate_bombs
    fill_all_tiles
  end

  def []=(pos, val)
    debugger
    row, col = pos
    @board[row][col] = val
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def generate_bombs
    num_bombs = (@size ** 2)/4
    num_bombs.times do
        row = rand(0..@size - 1)
        col = rand(0..@size - 1)
        @board[row][col].value = "b"
    end
  end

  def fill_all_tiles
    @board.each_with_index do |row, row_idx|
      row.each.with_index do |tile, cell_idx|
        if !tile.is_bomb?
          tile.value = (adj_bombs([row_idx, cell_idx]))
        end
      end
    end
  end

  def adj_bombs(pos)
    adj_cells(pos).count {|tile| tile.is_bomb?}
  end

  def adj_cells(pos)
    adj_tiles = []
    row, col = pos
    row_start = row.zero? ? 0 : row - 1
    col_start = col.zero? ? 0 : col - 1
    @board[row_start..row+1].each do |row|
      row[col_start..col+1].each {|cell| adj_tiles << cell unless cell.nil?}
    end
    adj_tiles.delete(@board[row][col])
    adj_tiles
  end

  def each_tile(&prc)
    @board.each do |row|
      row.each do |cell|
        prc.call(cell)
      end
    end
  end

  def make_move(pos)
   row, col = pos
   @board[row][col].reveal
  end


  def render
    @board.each do |row|
      row.each do |cell|
        print "#{cell}|"
      end
      puts ""
    end
  end
end
