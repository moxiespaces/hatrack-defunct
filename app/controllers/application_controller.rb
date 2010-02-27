# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :clear_identity_map
  
  def clear_identity_map
    MongoMapper::Plugins::IdentityMap.models.each{|m| m.identity_map.clear}
  end
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
