require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe 'yellow hat' do
  it "should work with machinist" do
    lambda{YellowHat.make}.should_not raise_error
  end
end
