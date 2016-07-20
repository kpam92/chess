class NilPiece
  include Singleton
  def color
    :nil
  end
  def to_s
    return '   '
  end
  def board
    nil
  end

  def pos
    nil
  end

  def dup(board)
    self
  end

  def moves
    []
  end

  def type
    :nil
  end

end
