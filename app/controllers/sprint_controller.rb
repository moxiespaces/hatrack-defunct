class SprintController < ApplicationController
  before_filter :authenticate_user!

  layout 'hatrack'

  def index
    @sprints = current_user.sprints.all
    if @sprints.blank?
      sprint = Sprint.new(:name => 'Current Sprint')
      current_user.sprints << Sprint.new(:name => 'Current Sprint',:start_date => Date.today)
      @sprints = [sprint]
    end
    @current_sprint = @sprints.first
  end

  def show
    @sprints = current_user.sprints.all(:order => 'created_at desc')
    @current_sprint = current_user.sprints.find(params[:id])
    render :template => '/sprint/index'
  end

  def set_font_size
    session[:font_size] = params[:size]
    render :template => false, :layout => false
  end
  

  def new
    @sprint = Sprint.new(:name => 'New Sprint',:start_date => Date.today)
    current_user.sprints << Sprint.new
    redirect_to(:action => :index)
  end

  def update
    sprint = current_user.sprints.find(params[:id])
    sprint.name = params[:sprint][:name]
    sprint.start_date = Date.parse(params[:sprint][:start_date])
    sprint.end_date = Date.parse(params[:sprint][:end_date])
    sprint.save
    redirect_to(:action => :show, :id => params[:id])
  end
end
