class Bicycle
  attr_reader :size, :parts

  def initialize(args={})
    @size  = args[:size]
    @parts = args[:parts]
  end

  def spares
    parts.spares
  end
end

class Parts
  attr_reader :chain, :tire_size

  def initialize(args={})
    @chain = args[:chain] || default_chain
    @tire_size  =  args[:tire_size]  || default_tire_size
    local_initialize(args)
  end

  def spares
    { 
      tire_size: tire_size,
      chain: chain
    }.merge(local_spares)
  end

  def default_tire_size
    raise NotImplementedError
  end

  # subclasses may override
  def local_initialize(args)
    nil
  end
  
  def local_spares
    {}
  end
  
  def default_chain
    '10-speed'
  end
end


class MountainBikeParts < Parts
  attr_reader :front_shock, :rear_shock

  def local_initialize(args={})
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
  end

  def default_tire_size
    "2.1"
  end

  def local_spares
    { :rear_shock => rear_shock }
  end
end

class RoadBikeParts < Parts
  attr_reader :tape_color 

  def local_initialize(args={})
    @tape_color = args[:tape_color]
  end

  def default_tire_size
    "23"
  end

  def local_spares
    { :tape_color => tape_color }
  end
end

road_bike = Bicycle.new(
  :size  => 'L',
  :parts => RoadBikeParts.new(
    :tape_color => "red",
    :chain      => "8.5-speed"
  )
)

mountain_bike = Bicycle.new(
  :size  => 'M',
  :parts => MountainBikeParts.new(
    :rear_shock => "Fox",
    :chain      => "12-speed"
  )
)

p road_bike.spares
p mountain_bike.spares