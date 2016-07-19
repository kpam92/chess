require_relative 'display'
class Player
attr_accessor :color, :board
attr_reader :name

def initialize(name)
  @name = name
end

def get_from_pos
  @display = Display.new(@board)
  result = nil
  until result
    @display.render
    result = @display.get_input
  end
  result
end

def get_to_pos
  @display = Display.new(@board)
  result = nil
  until result
    @display.render
    result = @display.get_input
  end
  result
end
end
