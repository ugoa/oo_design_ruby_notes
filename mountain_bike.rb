require './bicycle'

class MountainBike < Bicycle
  attr_reader :front_shock, :rear_shock

  def local_initialize(args={})
    @front_shock = args[:front_shock]
    @rear_shock  = args[:rear_shock]
  end

  def default_tire_size
    2.1
  end

  def local_spares
    { :rear_shock => rear_shock }
  end
end

# mount = MountainBike.new({
#               :front_shock => 3,
#               :rear_shock  => 4,
#               :size        => 11,
#               :chain       => "13-speed",
#               :tire_size   => 15 })

# p mount.spares

