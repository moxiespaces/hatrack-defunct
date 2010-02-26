class SprintController < ApplicationController
  before_filter :authenticate_user!

  layout 'hatrack'

  def index
    @sprints = current_user.sprints.all
    if @sprints.blank?
      sprint = current_user.sprints << Sprint.new(:name => 'Current Sprint')
      @sprints = [sprint]
    end

    @current_sprint = @sprints.first
  end

  def show
    @sprints = current_user.sprints.all(:order => 'created_at desc')
    @current_sprint = current_user.sprints.find(params[:id])
  end

  def set_font_size
    session[:font_size] = params[:size]
    render :template => false, :layout => false
  end
  

  def new
    @sprint = current_user.sprints << Sprint.new
    redirect_to(:action => :index)
  end

  def update
    
  end

end
