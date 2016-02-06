class Vehicle
  def acelerate(ratio = 10)
  end

  def brake(ratio = 10)
  end

  def turn(direction:, degree:10)
  end
end

class Car < Vehicle
  attr_reader :engine, :wheels, :bodyshop
  attr_accessor :model, :factory

  def Car.basic
  end

  def Car.sport
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

class Door
  def open
  end
  def close
  end
end

class Key end

class Engine
  attr_accessor :oil_level
end

class Wheel
  attr_reader :inches
  attr_writer :air

  def Wheel.basic
  end
end

class Bodyshop
  attr_accessor :doors, :width
  attr_accessor :height, :lenght
end
