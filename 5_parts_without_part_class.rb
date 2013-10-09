require "forwardable"
require "ostruct"

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

road_config = [['chain', '10-speed'], ['tire_size', '23'], ['tape_color', 'red']]
mountain_config = [
    ['chain'      , '10-speed'],
    ['tire_size'  , '2.1'],
    ['front_shock', 'Manitou', false],
    ['rear_shock' , 'Fox']]

module PartsFactory
  def self.build(config)
    Parts.new( config.collect { |part_config| create_part(part_config) })
  end

  def self.create_part(part_config)
    OpenStruct.new(
      :name        => part_config[0], 
      :description => part_config[1],
      :needs_spare => part_config.fetch(2, true))
  end
end

road_bike_parts = PartsFactory.build road_config
mount_bike_parts = PartsFactory.build mountain_config

p road_bike = Bicycle.new(
  :size => "XL",
  :parts => road_bike_parts)

p road_bike.spares