class Bicycle
  attr_reader :size, :parts_instance

  def initialize(args={})
    @size  = args[:size]
    @parts_instance = args[:parts]
  end

  def spares
    parts_instance.spares
  end
end

class Parts
  attr_reader :part_list

  def initialize(parts)
    @part_list = parts
  end

  def spares
    part_list.select { |part| part.needs_spare }
  end
end

class Part
  attr_reader :name, :description, :needs_spare

  def initialize(args={})
    @name        = args[:name]
    @description = args[:description]
    @needs_spare = args.fetch(:needs_spare, true)
  end
end


chain =
Part.new(name: 'chain', description: '10-speed')

road_tire =
Part.new(name: 'tire_size', description: '23')

tape =
Part.new(name: 'tape_color', description: 'red')

mountain_tire =
Part.new(name: 'tire_size', description: '2.1')

rear_shock =
Part.new(name: 'rear_shock', description: 'Fox')

front_shock = Part.new(
  :name        => 'front_shock',
  :description => 'Manitou',
  :needs_spare => false
)

road_bike_parts = Parts.new([chain, road_tire, tape, front_shock])

road_bike = Bicycle.new(
  :size => "XL",
  :parts => road_bike_parts 
)

p road_bike.parts_instance
p road_bike.spares