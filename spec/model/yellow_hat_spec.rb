require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe YellowHat do
  it { should belong_to :sprint }
  it { should work_with_machinist }
end
