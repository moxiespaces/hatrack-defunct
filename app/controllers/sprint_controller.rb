class SprintController < ApplicationController
  before_filter :authenticate_user!

  layout 'hatrack'

  def index
<<<<<<< HEAD
    @sprints = Sprint.all(:order => 'start_date')
    if @sprints.blank?
      sprint = Sprint.new(:name => 'New Sprint',:start_date => Date.today)
      sprint.save!
=======
    @sprints = current_user.sprints.all
    if @sprints.blank?
      sprint = Sprint.new(:name => 'Current Sprint')
      current_user.sprints << Sprint.new(:name => 'Current Sprint')
>>>>>>> c0bab086faad2c0bf8444dfb5db66c72f17333bf
      @sprints = [sprint]
    end

    @current_sprint = @sprints.first
  end

  def show
<<<<<<< HEAD
    @sprints = Sprint.all(:order => 'start_date')
    @current_sprint = @current_sprint || Sprint.find(params[:id])
    render :template => '/sprint/index'
=======
    @sprints = current_user.sprints.all(:order => 'created_at desc')
    @current_sprint = current_user.sprints.find(params[:id])
>>>>>>> c0bab086faad2c0bf8444dfb5db66c72f17333bf
  end

  def set_font_size
    session[:font_size] = params[:size]
    render :template => false, :layout => false
  end
  

  def new
<<<<<<< HEAD
    #Sprint.sort(:end_date)
    @sprint = Sprint.create(:name => 'New Sprint',:start_date => Date.today)
=======
    @sprint = Sprint.new
    current_user.sprints << Sprint.new
>>>>>>> c0bab086faad2c0bf8444dfb5db66c72f17333bf
    redirect_to(:action => :index)
  end

  def update
<<<<<<< HEAD
    sprint = Sprint.find(params[:id])
    sprint.name = params[:sprint][:name]
    sprint.start_date = Date.parse(params[:sprint][:start_date])
    sprint.end_date = Date.parse(params[:sprint][:end_date])
    sprint.save
    redirect_to(:action => :show, :id => params[:id])
=======
>>>>>>> c0bab086faad2c0bf8444dfb5db66c72f17333bf
  end
end
