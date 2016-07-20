require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  def initialize(board, cursor_pos = [0,0],piece = nil)
    @board = board
    @cursor_pos = cursor_pos
    @current_piece = piece
  end

  def build_grid
    @board.grid.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color = piece.color
      color_options = colors_for(i, j,color)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j,color)
    moves_array = []
    moves_array = @piece.moves unless @piece.nil?
    if [i, j] == @cursor_pos
      bg = :light_red
    elsif moves_array.include?([i,j])
      bg = :light_yellow
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :cyan
    end
    { background: bg, color: color }
  end

  def render
    system("clear")
    build_grid.each { |row| puts row.join }
  end
end
