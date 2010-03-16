class Sprint
  include MongoMapper::Document

  key :name, String
  key :start_date, Date
  key :end_date, Date
  timestamps!

  many :blue_hats
  many :white_hats
  many :yellow_hats
  many :black_hats
  many :red_hats

  belongs_to :user

end
