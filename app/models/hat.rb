class Hat
  include MongoMapper::EmbeddedDocument

  key :text, String
end
