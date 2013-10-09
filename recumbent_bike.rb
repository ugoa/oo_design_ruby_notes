require './bicycle'

class RecumbentBike < Bicycle
  attr_reader :flag

  def local_initialize(args={})
    @flag = args[:flag]
  end

  def local_spares
    { :flag => flag }
  end

  def default_chain
    "8-speed"
  end

  def default_tire_size
    '28'
  end
end

bent = RecumbentBike.new({:flag => "tall and orange"})

p bent.spares


