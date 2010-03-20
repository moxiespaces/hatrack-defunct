class Sprint < ActiveRecord::Base
  has_many :yellow_hats
  has_many :black_hats

  belongs_to :user
end

# == Schema Information
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

