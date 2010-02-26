require 'test_helper'

class SprintTest < ActiveSupport::TestCase
  test "sprint machinist" do
    assert_nothing_raised{Sprint.make}
  end
end

# == Schema Information
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

