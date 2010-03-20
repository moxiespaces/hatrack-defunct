class BlackHat < ActiveRecord::Base

  has_one :green_hat
  belongs_to :sprint
end



# == Schema Information
#
# Table name: black_hats
#
#  id         :integer         not null, primary key
#  text       :string(255)
#  sprint_id  :integer
#  promotions :integer
#  created_at :datetime
#  updated_at :datetime
#

