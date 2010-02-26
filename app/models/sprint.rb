class Sprint
  include MongoMapper::Document

  key :name, String
  key :start_date, Date
  key :end_date, Date
  timestamps!

  many :yellow_hats
  many :black_hats

  belongs_to :user

  def print_start_date
    start_date ?  start_date.strftime("%m/%d") : 'asdf'
  end

  def print_end_date
    end_date ? end_date.strftime("%m/%d") : "Current"
  end
end
