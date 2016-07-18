# require_relative 'board'
require 'singleton'

class Piece

  attr_reader :color, :pos, :board, :type

  def initialize(color,board,pos, type)
    @color = color
    @board = board
    @pos = pos
    @type = type
  end

  def to_s
    @type.to_s[0].upcase
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

  def off_board?(pos)
    row,col = pos[0],pos[1]
    !(row.between?(0,7) && col.between?(0,7))
  end

end #end of Piece class

class NilPiece < Piece
  include Singleton
end


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

  def initialize(color,board,pos,type)
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
      until off_board?([row_current,col_current]) ||same_color?(self,piece2)
        piece2 = @board[[row_current,col_current]]
        moves << [row_current,col_current]
        break unless same_color?(self,piece2) || piece2.type.nil?
        row_current += d_row
        col_current += d_col

      end
    end
    moves
  end #end of moves method
end # end of SlidingPiece class

class SteppingPiece < Piece

  def initialize(color,board,pos,type)
    super
  end

  def moves
  end

end # end of SteppingPiece class
