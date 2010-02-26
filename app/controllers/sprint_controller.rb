class SprintController < ApplicationController
  layout 'hatrack'

  def index
    @sprints = Sprint.all
    if @sprints.blank?
      sprint = Sprint.new(:name => 'Current Sprint')
      sprint.save!
      @sprints = [sprint]
    end

    @current_sprint = @sprints.first
  end

  def show
    @sprints = Sprint.find(:all, :order => 'created_at desc')
    @current_sprint = Sprint.find(params[:id])
  end

  def set_font_size
    session[:font_size] = params[:size]
    render :template => false,:layout => false
  end
  

  def new
    @sprint = Sprint.create
    redirect_to(:action => :index)
  end

  def update
    
  end

end
