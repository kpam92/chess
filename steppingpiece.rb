require_relative 'chess_piece'

class SteppingPiece < Piece

KNIGHT_MOVES = [
  [2,1],
  [2,-1],
  [-2,1],
  [-2,-1],
  [1,2],
  [1,-2],
  [-1,2],
  [-1,-2]
]
KING_MOVES = [
  [0,1],
  [1,0],
  [0,-1],
  [-1,0],
  [1, 1],
  [-1, 1],
  [-1, -1],
  [1, -1]
]
MOVES_HASH = {
  :knight => KNIGHT_MOVES,
  :king => KING_MOVES
}
  def initialize(color,pos,board,type)
    super
  end

  def moves
    moves = []
    MOVES_HASH[type].each do |direction|
      row_current, col_current = self.pos[0], self.pos[1]
      d_row, d_col = direction[0],direction[1]
      row_current += d_row
      col_current += d_col
      piece2 = @board[[row_current,col_current]]
      unless same_color?(self,piece2) || off_board?([row_current,col_current])
        moves << [row_current,col_current]
      end
    end #end
    moves
  end
end # end of SteppingPiece class
