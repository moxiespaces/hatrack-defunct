class Sprint
  include MongoMapper::Document

  key :name, String
  key :start_date, Date
  key :end_date, Date
  timestamps!

  many :yellow_hats
  many :black_hats
end


