require "test/unit"
require "./bicycle"

class BicycleTest < Test::Unit::TestCase
  def test_truth
    b = Mechanic.new
    assert_equal(6, b.lead_days, "Haha you are idiot")
  end
end