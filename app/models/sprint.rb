class Sprint
  include MongoMapper::Document

  key :name, String
  timestamps!

  many :yellow_hats
  many :black_hats

  belongs_to :user
end
