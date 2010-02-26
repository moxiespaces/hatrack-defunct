config = YAML.load(File.read(File.join(Rails.root, "config", "mongo.yml")))
MongoMapper.setup(config, Rails.env)
MongoMapper.database.authenticate('theath', 'omgmongo') if Rails.env == "production"

module IdentityMapAddition
  def self.included(model)
    model.plugin MongoMapper::Plugins::IdentityMap
  end
end

MongoMapper::Document.append_inclusions(IdentityMapAddition)
