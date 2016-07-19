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
    @current_player = @player1
  end

  def play
    stop = false
    until stop
      @board.render
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
      player.get_from_pos
      puts "pick your move"
      to_pos = gets.chomp.split(",").map(&:to_i)
      turn_complete = @board.move_piece(player.color,from_pos,to_pos)
      puts "#{turn_complete}"
      sleep(1)
    end
    puts "turn is complete"
    sleep(1)
  end
end #end of game class
kevin = Player.new("Kevin")
josh = Player.new("Josh")
Game.new(kevin,josh).play
