require_relative 'chess_piece'

class Board
  attr_reader :grid
  def initialize
    make_starting_grid
    populate_board
    # render
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8){Piece.new(:nil,nil,nil,:nil)}}
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
    self[[1,0]] = Pawn.new(:black,[1,0],self,:pawn)
    self[[1,1]] = Pawn.new(:black,[1,1],self,:pawn)
    self[[1,2]] = Pawn.new(:black,[1,2],self,:pawn)
    self[[1,3]] = Pawn.new(:black,[1,3],self,:pawn)
    self[[1,4]] = Pawn.new(:black,[1,4],self,:pawn)
    self[[1,5]] = Pawn.new(:black,[1,5],self,:pawn)
    self[[1,6]] = Pawn.new(:black,[1,6],self,:pawn)
    self[[1,7]] = Pawn.new(:black,[1,7],self,:pawn)

    self[[7,0]] = SlidingPiece.new(:white,[7,0],self,:rook)
    self[[7,1]] = SteppingPiece.new(:white,[7,1],self,:knight)
    self[[7,2]] = SlidingPiece.new(:white,[7,2],self,:bishop)
    self[[7,3]] = SlidingPiece.new(:white,[7,3],self,:queen)
    self[[7,4]] = SteppingPiece.new(:white,[7,4],self,:king)
    self[[7,5]] = SlidingPiece.new(:white,[7,5],self,:bishop)
    self[[7,6]] = SteppingPiece.new(:white,[7,6],self,:knight)
    self[[7,7]] = SlidingPiece.new(:white,[7,7],self,:rook)
    self[[6,0]] = Pawn.new(:white,[6,0],self,:pawn)
    self[[6,1]] = Pawn.new(:white,[6,1],self,:pawn)
    self[[6,2]] = Pawn.new(:white,[6,2],self,:pawn)
    self[[6,3]] = Pawn.new(:white,[6,3],self,:pawn)
    self[[6,4]] = Pawn.new(:white,[6,4],self,:pawn)
    self[[6,5]] = Pawn.new(:white,[6,5],self,:pawn)
    self[[6,6]] = Pawn.new(:white,[6,6],self,:pawn)
    self[[6,7]] = Pawn.new(:white,[6,7],self,:pawn)


  end

  # def rotate
  #   2.times {@grid = @grid.transpose.reverse}
  # end

  def render
    puts
    # system('clear')
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
    begin
      piece = @grid[pos[0]][pos[1]]
      piece ||= Piece.new(:nil,nil,nil,:nil)
    rescue
      return Piece.new(:nil,nil,nil,:nil)
    end
  end

  def deep_dup
    board_copy = Board.new
    for row in 0..7 do
      for col in 0..7 do
        board_copy[[row,col]] = self[[row,col]].dup
      end
    end
    board_copy
  end

  def move_piece(color,from_pos,to_pos)

    current_piece = self[from_pos]
    possible_moves = current_piece.moves
    if current_piece.color == color && possible_moves.include?(to_pos)
      move_piece!(from_pos,to_pos)
    end

  end

  def move_piece!(from_pos,to_pos)
    current_piece = self[from_pos]
    puts "current_piece is #{current_piece} at #{current_piece.pos}"
    self[to_pos] = current_piece
    self[from_pos] = Piece.new(:nil,nil,nil,:nil)
    current_piece.pos = to_pos
  end

  def exposing_king?(color,from_pos,to_pos)
    puts "rendering original board"
    self.render
    board_copy = self.deep_dup
    puts "rendering new board"
    board_copy.render
    board_copy.move_piece!(from_pos,to_pos)
    king_pos = board_copy.find_king(color)
    board_copy.grid.flatten.each do |el|
      puts "element considered is a #{el.color}#{el}"
      # byebug if el.type == :queen
      unless el.color == color
        possible_moves = el.moves
        print board_copy[[6,4]] if el.type == :queen && el.color == :black
        print possible_moves if el.type == :queen && el.color == :black

        return true if possible_moves.include?(king_pos)
      end
    end
    return false
  end

  def check_mate?
  end

  def find_king(color)
    k_pos = nil
    @grid.flatten.each do |x|
      k_pos = x.pos if x.type == :king && x.color == color
    end
    k_pos
  end

end
a = Board.new
a.move_piece!([0,3],[2,4])
print a.exposing_king?(:white,[6,4],[5,3])
