require File.join(File.dirname(__FILE__), '../test_helper')

class YellowHatTest < ActiveSupport::TestCase
  test "yellowhat machinist" do
    assert_nothing_raised{YellowHat.make}
  end
end
