class Board

  def initialize
    make_starting_grid
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8)}
    #populate grid with chess pieces and such
  end

  def []=(pos,piece)
    @grid[pos[0]][pos[1]] = piece
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def dup
  end

  def move_piece(color,from_pos,to_pos)
  end

  def move_piece!(from_pos,to_pos)
  end

  def check_mate?
  end

  def find_king(color)
  end

end
