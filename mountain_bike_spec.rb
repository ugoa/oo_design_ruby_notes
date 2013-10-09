require './mountain_bike'

describe MountainBike do
  before(:each) do
    @bike = MountainBike.new({
      :front_shock => 3,
      :rear_shock  => 4,
      :size        => 11,
      :chain       => "13-speed",
      :tire_size   => 2.11 })
  end

  it "mountain bike's chain should be '13-speed'" do
   @bike.chain.should == '13-speed'
  end

  it "mountain bike's tire_size should be 2.1" do
    @bike.tire_size.should be_within(0.02).of(2.1)
    # expect(@bike.default_tire_size).to eql(2.1)
  end
end