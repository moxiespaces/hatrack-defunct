require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe User do
  it { should work_with_machinist }
  it { should have_many :sprints }
end
