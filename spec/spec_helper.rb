# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
require 'spec/autorun'
require 'spec/rails'

require 'remarkable_rails'

require File.join(File.dirname(__FILE__), 'blueprints')

# Uncomment the next line to use webrat's matchers
#require 'webrat/integrations/rspec-rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

module MachinistMacro
  class MachinistMatcher
    def matches?(item)
      item.class.make
      return true
    rescue
      return false
    end

    def description
      "works if there's a valid blueprint"
    end

    def failure_message_for_should
      "expected #{@subject} to have valid blueprint"
    end

    def failure_message_for_should_not
      "wtf?"
    end
  end

  def work_with_machinist
    MachinistMatcher.new
  end
end

Spec::Runner.configure do |config|
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each) do 
    Sham.reset(:before_each)
  end
  config.include(MachinistMacro)
end

