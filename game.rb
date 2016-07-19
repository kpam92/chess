require 'board'
require 'chess_piece'

class Game

attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @player1.color = :white
    @player2.color = :black
    @board = Board.new
  end

  def play
    stop = false
    until stop
      take_turn
      switch_player
    end
  end

  def switch_player
  end

  def take_turn(player)
    turn_complete = false
    until turn_complete
      puts "pick your piece"
      from_pos = gets.chomp.split(",").map(&:to_i)
      puts "pick your move"
      to_pos = gets.chomp.split(",").map(&:to_i)
      turn_complete = @board.move(player.color,from_pos,to_pos)
    end
  end
end #end of game class
