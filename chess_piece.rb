require 'byebug'
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
