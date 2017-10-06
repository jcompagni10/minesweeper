class Board
  def initialize(size)
    @size = size
    @board = Array.new(size) {Array.new(size)}
    generate_bombs
  end

  def generate_bombs
    num_bombs = (@size ** 2)/8
    num_bombs.times do
        row = rand(0..@size - 1)
        col = rand(0..@size - 1)
        @board[row][col] = Tile.new("b")
    end
  end

  def fill_all_tiles
    @board.each_with_idx do |row, row_idx|
      row.map!.with_index do |cell, cell_idx|
        if cell.is_bomb?
          next
        else
          cell = Tile.new(adj_bombs(row_idx, cell_idx))
        end
      end
    end
  end

  def adj_bombs(row, col)
    adj_cells(row, col).count {|tile| tile.is_bomb?}
  end

  def adj_cells(row, col)
    tiles = []
    row_start = row.zero? ? 0 : row - 1
    col_start = col.zero? ? 0 : row - 1
    (row_start..row+1).each do |row|
      (col_start..col+1).each {|cell| tiles << cell unless cell.nil?}
    end
    tiles.delete(@board[row][col])
    tiles
  end

end
