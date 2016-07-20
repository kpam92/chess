class Airplane
  def fly
    start_engine
    puts"flying"
  end

  protected
  def start_engine
    puts "starting engine"
  end
end

class Car
  def start_plane_engine(airplane)
    airplane.start_engine
  end

end

a = Airplane.new
b = Car.new
b.start_plane_engine(a)
