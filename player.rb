require_relative 'display'
class Player
attr_accessor :color, :board
attr_reader :name

def initialize(name)
  @name = name
end

def get_from_pos
  @display = Display.new(@board)
  from_pos = nil
  until from_pos
    @display.render
    from_pos= @display.get_input
  end
  @from_pos = from_pos
  from_pos
end

def get_to_pos
  from_piece = @board[@from_pos]
  @display = Display.new(@board,@from_pos,from_piece)
  to_pos = nil
  until to_pos
    @display.render
    to_pos = @display.get_input
  end
  @from_pos = nil
  to_pos
end
end
