
require_relative 'chess_piece'

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
