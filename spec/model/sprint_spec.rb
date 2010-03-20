require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe Sprint do
  it { should have_many :yellow_hats }
  it { should have_many :black_hats }
  it { should belong_to :user }
  it { should work_with_machinist }
end
