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
