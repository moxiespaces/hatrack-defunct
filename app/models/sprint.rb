class Sprint < ActiveRecord::Base

  #key :name, String
  #key :start_date, Date
  #key :end_date, Date
  #timestamps!

  #many :blue_hats
  #many :white_hats
  #many :yellow_hats
  #many :black_hats
  #many :red_hats

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

