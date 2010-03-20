class SprintsController < ApplicationController
  before_filter :authenticate_user!

  layout 'hatrack'

  def index
    @sprints = current_user.sprints.all(:order => 'end_date desc, start_date desc')
    @current_sprint = @sprints.first || current_user.sprints.create(:name => "Current Sprint", :start_date => Date.today)
    @sprints = @sprints - [@current_sprint]
  end

  def show
    @sprints = current_user.sprints.all(:order => 'end_date desc, start_date desc')
    @current_sprint = current_user.sprints.find(params[:id])
    @sprints = @sprints - [@current_sprint]
    render :template => '/sprints/index'
  end

  def set_font_size
    session[:font_size] = params[:size]
    render :template => false, :layout => false
  end


  def create
    current_user.sprints.all(:conditions => {:end_date => nil} ).each do |sprint|
      sprint.end_date = Date.today
      sprint.save
    end

    name = params[:sprint][:name].blank? ? 'New Sprint' : params[:sprint][:name]
    date = params[:sprint][:start_date].blank? ? Date.today : Date.parse(params[:sprint][:start_date])
    current_user.sprints << Sprint.new(:name => name, :start_date => date)
    redirect_to(:action => :index)
  end

  def update
    sprint = current_user.sprints.find(params[:id])
    sprint.name = params[:sprint][:name]
    sprint.start_date = !params[:sprint][:start_date].blank? ? Date.parse(params[:sprint][:start_date]) : sprint.start_date
    sprint.end_date = !params[:sprint][:end_date].blank? ? Date.parse(params[:sprint][:end_date]) : ''
    sprint.save
    redirect_to(:action => :show, :id => params[:id])
  end


end
