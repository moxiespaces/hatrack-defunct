class Hat
  include MongoMapper::EmbeddedDocument

  key :text, String
  key :created_at, Time
end
