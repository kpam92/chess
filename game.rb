require_relative 'board'
require_relative 'chess_piece'
require_relative 'player'

class Game
attr_accessor :current_player
attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @player1.color = :white
    @player2.color = :black
    @board = Board.new
    @player1.board = @board
    @player2.board = @board
    @current_player = @player1
  end

  def play
    stop = false
    until stop
      take_turn(@current_player)
      switch_player
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def take_turn(player)
    turn_complete = false
    until turn_complete
      puts "pick your piece, #{player.name}!"
      from_pos = player.get_from_pos
      puts "pick your move"
      to_pos = player.get_to_pos
      turn_complete = @board.move_piece(player.color,from_pos,to_pos)
    end
    if rand(100) > 50
      puts "I don't know about that..."
    else
      puts "Nice move!"
    end
    sleep(1)
  end
end #end of game class
kevin = Player.new("Kevin")
josh = Player.new("Josh")
Game.new(kevin,josh).play
