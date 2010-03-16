class Pref
  include MongoMapper::Document

  key :colors, Array

  belongs_to :user

  def initialize(c = nil, b = nil)
    # Terry why do i need c and b, it was giveing me err
    super
    self.colors = %w( yellow black )
  end
end