require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe BlackHat do
  it { should work_with_machinist }
  it { should have_one :green_hat }
  it { should belong_to :sprint }
end
