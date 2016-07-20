require 'byebug'
# require_relative 'board'
require 'singleton'


class Piece
  attr_reader :color, :board, :type
  attr_accessor :pos

  def initialize(color,pos,board,type)
    @color = color
    @board = board
    @pos = pos
    @type = type
  end

  def dup(board)
    if self.type == :nil
      return Piece.new(:nil,nil,board,:nil)
    end
    self.class.new(self.color,self.pos.dup,board,self.type)
  end

  def to_s
    icon_symbol = UNI_SYMBOL[(color.to_s + type.to_s).to_sym]
    icon_symbol.encode('utf-8')
    output = " #{icon_symbol} "
  end

  protected

  UNI_SYMBOL = {
    :whiteking => "\u2654",
     :whitequeen => "\u2655",
     :whiterook => "\u2656",
     :whitebishop => "\u2657",
     :whiteknight => "\u2658",
     :whitepawn => "\u2659",
     :blackking => "\u265A",
      :blackqueen => "\u265B",
      :blackrook => "\u265C",
      :blackbishop => "\u265D",
      :blackknight => "\u265E",
      :blackpawn => "\u265F",
      :nilnil => "\u0020",
      :blacknil => "\u0020"
  }
  REVERSE_COLOR = {:white => :black, :black => :white}
  
  def same_color?(piece1,piece2)
    return false if piece1.nil? || piece2.nil?
    piece1.color == piece2.color
  end

  def off_board?(pos)
    row,col = pos[0],pos[1]
    !(row.between?(0,7) && col.between?(0,7))
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

class Pawn < Piece
  FORWARD = {:white=> [-1,0],:black => [1,0]}
  STARTING_ROW = {:white=> 6,:black => 1}
  def initialize(color,pos,board,type)
    super
  end

  def moves
    moves = []
    forward = FORWARD[@color]
    row_current, col_current = @pos[0] + forward[0], @pos[1] + forward[1]
    if @board[[row_current,col_current]].type == :nil
      moves << [row_current, col_current]
    end

    if @pos[0] == STARTING_ROW[@color] && moves.length == 1
      row_current, col_current = @pos[0] + 2*forward[0], @pos[1] + 2*forward[1]
      if @board[[row_current,col_current]].type == :nil
        moves << [row_current, col_current]
      end
    end

    moves += side_attacks
    moves
  end

  def side_attacks
    output = []

    forward_row = @pos[0] + FORWARD[@color][0]
    left_attack = [forward_row, @pos[1]-1]
    right_attack =[forward_row, @pos[1]+1]
    piece2 = @board[left_attack]
    # byebug
    if piece2.type != :nil && !same_color?(self,piece2)
      output << left_attack
    end
    piece2 = @board[right_attack]
    # byebug
    if piece2.type != :nil && !same_color?(self,piece2)
      output << right_attack
    end
    output


  end



end

class NilPiece
  include Singleton
  def color
    :nil
  end
  def to_s
    return '   '
  end
  def board
    nil
  end

  def pos
    nil
  end

  def dup(board)
    self
  end

  def moves
    []
  end

  def type
    :nil
  end

end
