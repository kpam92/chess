require_relative 'chess_piece'

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

  def initialize(color,pos,board,type)
    super
  end

  # def dup(board)
  #   super
  # end

  def moves
    moves = []
    MOVES_HASH[type].each do |direction|
     row_current, col_current = self.pos[0], self.pos[1]
     d_row, d_col = direction[0], direction[1]
     keep_going = true
     while keep_going
       row_current += d_row
       col_current += d_col
       piece_current = @board[[row_current,col_current]]
       unless off_board?([row_current,col_current])
         if piece_current.type == :nil || !same_color?(self, piece_current)
           moves <<[row_current,col_current]
         else
           keep_going = false
         end

       else
         keep_going = false
       end
     end
   end
   moves
 end # end of moves

end # end of SlidingPiece class
