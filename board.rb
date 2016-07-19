require_relative 'chess_piece'

class Board
  attr_reader :grid
  attr_accessor :color_in_check
  def initialize
    make_starting_grid
    populate_board
    # render
  end

  def make_starting_grid
    @grid = Array.new(8) { Array.new(8){Piece.new(:nil,nil,nil,:nil)}}
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

  def render

    puts
    @grid.each do |row|
      row.each do |el|
        print "[#{el.to_s}] "
      end
      puts
    end
    nil
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
        cp = self[[row,col]]
        np = cp.dup(board_copy)
        board_copy[[row,col]] = np
      end
    end
    board_copy
  end

  def move_piece(color,from_pos,to_pos)

    current_piece = self[from_pos]
    possible_moves = current_piece.moves
    if current_piece.color == color &&
      possible_moves.include?(to_pos) && !exposing_king?(color,from_pos,to_pos)
      move_piece!(from_pos,to_pos)
      return true
    end
    false
  end

  def move_piece!(from_pos,to_pos)
    current_piece = self[from_pos]
    self[to_pos] = current_piece
    self[from_pos] = Piece.new(:nil,nil,nil,:nil)
    current_piece.pos = to_pos
  end

  def exposing_king?(color,from_pos,to_pos)
    board_copy = self.deep_dup
    board_copy.move_piece!(from_pos,to_pos)
    king_pos = board_copy.find_king(color)
    king = board_copy[king_pos]
    board_copy.grid.flatten.each do |el|
      return true if can_king_be_killed?(king,el)
    end
    return false
  end

  def can_king_be_killed?(king,piece)
    return true if piece.moves.include?(king.pos) && king.color != piece.color
    false
  end

  def check?(color)
    king_pos = find_king(color)
    king = self[king_pos]
    self.grid.flatten.any? do |el|
      can_king_be_killed?(king,el)
    end
  end

  def check_mate?(color)
    pieces = []
    @grid.flatten.each do |el|
      if el.color == color
        pieces << el
      end
    end
    check_mate_boolean = true
    pieces.each do |piece|
      current_pos = piece.pos
      piece.moves.each do |move|
        current_board = self.deep_dup
        current_board.move_piece!(current_pos,move)
        check_mate_boolean = check_mate_boolean && current_board.check?(color)
        puts "current piece is #{piece.to_s}"
        print "piece is moving from #{current_pos} to #{move}"
        puts
        puts "current board is in check? #{current_board.check?(color)}"
        # byebug
      end
    end
    check_mate_boolean
  end

  def find_king(color)
    k_pos = nil
    @grid.flatten.each do |x|
      k_pos = x.pos if x.type == :king && x.color == color
    end
    k_pos
  end

  def in_bounds?(pos)
    pos[0].between?(0,7) && pos[1].between?(0,7)
  end

end
