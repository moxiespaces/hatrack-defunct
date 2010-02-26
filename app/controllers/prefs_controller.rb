class PrefsController < ApplicationController


  def index
    @sprints = Sprint.all
    if @sprints.blank?
      sprint = Sprint.new(:name => 'Current Sprint')
      sprint.save!
      @sprints = [sprint]
    end

    @current_sprint = @sprints.first
  end

end
