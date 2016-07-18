require_relative 'chess_piece'

class Board

  def initialize
    make_starting_grid
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8){Piece.new(nil,nil,nil,nil)}}
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
a = Board.new
rook = SlidingPiece.new("white",a,[2,2],:queen)
puts rook.type
puts rook.color
puts rook.board[[0,0]]
print rook.moves
