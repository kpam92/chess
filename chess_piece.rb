class Piece

  attr_reader :color, :pos, :board, :type

  def initialize(color,board,pos, type)
    @color = color
    @board = board
    @pos = pos
    @type = type
  end

  def to_s
  end

  def empty?
  end

  def symbol
  end

  def move_into_check?(to_pos)
  end

  def valid_moves
    # moves
  end

  def same_color?(piece1,piece2)
    piece1.color == piece2.color
  end

  def on_board?(pos)
    row,col = pos[0],pos[1]
    row.between?(0,7) && col.between?(0,7)
  end

end #end of Piece class

class SlidingPiece < Piece
BISHOP_MOVES = [
  [1, 1],
  [-1, 1],
  [-1, -1],
  [1, -1]
]
ROOK_MOVES = [
  [0,1],
  [1,0],
  [0,-1],
  [-1,0]
]
QUEEN_MOVES = BISHOP_MOVES + ROOK_MOVES
MOVES_HASH = {
    :bishop => BISHOP_MOVES,
    :rook => ROOK_MOVES,
    :queen => QUEEN_MOVES
  }

  def initialize(color,board,pos, type)
    super
  end

  def moves

  end
end # end of SlidingPiece class

class SteppingPiece < Piece

  def initialize(color,board,pos, type)
    super
  end

  def moves
  end

end # end of SteppingPiece class
