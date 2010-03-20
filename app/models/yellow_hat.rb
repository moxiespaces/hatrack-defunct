class YellowHat < ActiveRecord::Base
  belongs_to :sprint
end

# == Schema Information
#
# Table name: yellow_hats
#
#  id         :integer         not null, primary key
#  text       :string(255)
#  sprint_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

