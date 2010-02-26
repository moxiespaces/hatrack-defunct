class Sprint
  include MongoMapper::Document

  key :name, String
  key :start_date, Date
  key :end_date, Date
  timestamps!

  many :yellow_hats
  many :black_hats
<<<<<<< HEAD

  def print_start_date
    start_date.strftime("%m/%d")
  end

  def print_end_date
    end_date ? end_date.strftime("%m/%d") : "Current"
  end
end

=======
>>>>>>> c0bab086faad2c0bf8444dfb5db66c72f17333bf

  belongs_to :user
end
