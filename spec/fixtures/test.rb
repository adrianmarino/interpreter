module Vehicle
  def acelerate(ratio = 10)
  end

  def brake(ratio = 10)
  end

  def turn(direction:, degree:10)
  end
end

class Door end
class Key end
class Engine end

class Wheel
  attr_reader :inches
end

class Bodyshop
  attr_reader :doors
end

class Car
  include Vehicle

  attr_reader :engine, :wheels, :bodyshop

  def Car.basic
  end

  def initialize(engine, wheels, bodyshop)
  end

  def start_engine(key)
  end

  def stop_engine(key)
  end

  def fuelling(amount: 50.5)
  end
end
