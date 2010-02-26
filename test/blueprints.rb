require 'machinist/mongo_mapper'
require 'sham'
require 'faker'

MongoMapper::EmbeddedDocument.append_extensions(Machinist::Blueprints::ClassMethods)
MongoMapper::EmbeddedDocument.append_extensions(Machinist::MongoMapperExtensions::EmbeddedDocument)

Sprint.blueprint do
end

Hat.blueprint do
end

YellowHat.blueprint do
end

GreenHat.blueprint do
end

