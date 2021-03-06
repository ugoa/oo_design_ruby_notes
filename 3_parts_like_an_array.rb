require "forwardable"

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
  extend Forwardable
  def_delegators :@part_list, :size, :each
  include Enumerable

  def initialize(parts)
    @part_list = parts
  end

  def spares
    select { |part| part.needs_spare }
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


chain = Part.new(name: 'chain', description: '10-speed')

road_tire = Part.new(name: 'tire_size', description: '23')

tape = Part.new(name: 'tape_color', description: 'red')

mountain_tire = Part.new(name: 'tire_size', description: '2.1')

rear_shock = Part.new(name: 'rear_shock', description: 'Fox')

front_shock = Part.new(
  :name        => 'front_shock',
  :description => 'Manitou',
  :needs_spare => false)

road_bike_parts = Parts.new([chain, road_tire, tape, front_shock])

road_bike = Bicycle.new(
  :size => "XL",
  :parts => road_bike_parts)

road_bike = Bicycle.new(
  :size => "XL",
  :parts => road_bike_parts)

p road_bike.parts_instance
p road_bike.spares.size

mountain_bike = Bicycle.new(
  :size  => 'L',
  :parts => Parts.new([chain, mountain_tire, front_shock, rear_shock]))

p mountain_bike.parts_instance.size # -> 4
p mountain_bike.spares.size # -> 3
