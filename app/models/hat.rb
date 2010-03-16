class Hat
  include MongoMapper::EmbeddedDocument

  key :text, String
  key :created_at, Time

  COLORS = %w( blue white yellow black red )
end
