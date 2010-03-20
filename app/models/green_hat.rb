class GreenHat < ActiveRecord::Base

  #key :owner, String
end

# == Schema Information
#
# Table name: green_hats
#
#  id           :integer         not null, primary key
#  text         :string(255)
#  black_hat_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

