require_relative 'chess_piece'

class Board

  def initialize
    make_starting_grid
    populate_board
    render
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8){Piece.new(nil,nil,nil,:nil)}}
    #populate grid with chess pieces and such
  end

  def populate_board
    self[[0,0]] = SlidingPiece.new(:black,[0,0],self,:rook)
    self[[0,1]] = SteppingPiece.new(:black,[0,1],self,:knight)
    self[[0,2]] = SlidingPiece.new(:black,[0,2],self,:bishop)
    self[[0,3]] = SlidingPiece.new(:black,[0,3],self,:queen)
    self[[0,4]] = SteppingPiece.new(:black,[0,4],self,:king)
    self[[0,5]] = SlidingPiece.new(:black,[0,5],self,:bishop)
    self[[0,6]] = SteppingPiece.new(:black,[0,6],self,:knight)
    self[[0,7]] = SlidingPiece.new(:black,[0,7],self,:rook)
    self[[1,0]] = SteppingPiece.new(:black,[1,0],self,:pawn)
    self[[1,1]] = SteppingPiece.new(:black,[1,1],self,:pawn)
    self[[1,2]] = SteppingPiece.new(:black,[1,2],self,:pawn)
    self[[1,3]] = SteppingPiece.new(:black,[1,3],self,:pawn)
    self[[1,4]] = SteppingPiece.new(:black,[1,4],self,:pawn)
    self[[1,5]] = SteppingPiece.new(:black,[1,5],self,:pawn)
    self[[1,6]] = SteppingPiece.new(:black,[1,6],self,:pawn)
    self[[1,7]] = SteppingPiece.new(:black,[1,7],self,:pawn)

    self[[7,0]] = SlidingPiece.new(:white,[7,0],self,:rook)
    self[[7,1]] = SteppingPiece.new(:white,[7,1],self,:knight)
    self[[7,2]] = SlidingPiece.new(:white,[7,2],self,:bishop)
    self[[7,3]] = SlidingPiece.new(:white,[7,3],self,:queen)
    self[[7,4]] = SteppingPiece.new(:white,[7,4],self,:king)
    self[[7,5]] = SlidingPiece.new(:white,[7,5],self,:bishop)
    self[[7,6]] = SteppingPiece.new(:white,[7,6],self,:knight)
    self[[7,7]] = SlidingPiece.new(:white,[7,7],self,:rook)
    self[[6,0]] = SteppingPiece.new(:white,[6,0],self,:pawn)
    self[[6,1]] = SteppingPiece.new(:white,[6,1],self,:pawn)
    self[[6,2]] = SteppingPiece.new(:white,[6,2],self,:pawn)
    self[[6,3]] = SteppingPiece.new(:white,[6,3],self,:pawn)
    self[[6,4]] = SteppingPiece.new(:white,[6,4],self,:pawn)
    self[[6,5]] = SteppingPiece.new(:white,[6,5],self,:pawn)
    self[[6,6]] = SteppingPiece.new(:white,[6,6],self,:pawn)
    self[[6,7]] = SteppingPiece.new(:white,[6,7],self,:pawn)


  end

  # def rotate
  #   2.times {@grid = @grid.transpose.reverse}
  # end

  def render
    system('clear')
    @grid.each do |row|
      row.each do |el|
        print "[#{el.to_s}] "
      end
      puts
    end
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

a.populate_board
