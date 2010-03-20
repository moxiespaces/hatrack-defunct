require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe GreenHat do
  it { should work_with_machinist }
  it { should belong_to :black_hat }
end
