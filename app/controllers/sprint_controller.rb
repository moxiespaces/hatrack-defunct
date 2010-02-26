class SprintController < ApplicationController
  layout 'hatrack'

  def index
    @sprints = Sprint.all(:order => 'start_date')
    if @sprints.blank?
      sprint = Sprint.new(:name => 'New Sprint',:start_date => Date.today)
      sprint.save!
      @sprints = [sprint]
    end

    @current_sprint = @sprints.first
  end

  def show
    @sprints = Sprint.all(:order => 'start_date')
    @current_sprint = @current_sprint || Sprint.find(params[:id])
    render :template => '/sprint/index'
  end

  def set_font_size
    session[:font_size] = params[:size]
    render :template => false,:layout => false
  end
  

  def new
    #Sprint.sort(:end_date)
    @sprint = Sprint.create(:name => 'New Sprint',:start_date => Date.today)
    redirect_to(:action => :index)
  end

  def update
    sprint = Sprint.find(params[:id])
    sprint.name = params[:sprint][:name]
    sprint.start_date = Date.parse(params[:sprint][:start_date])
    sprint.end_date = Date.parse(params[:sprint][:end_date])
    sprint.save
    redirect_to(:action => :show, :id => params[:id])
  end

end
