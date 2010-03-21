class HatsController < ApplicationController
  before_filter :authenticate_user!

  def create
    sprint = current_user.sprints.find(params[:sprint_id])

    hat = (params[:type] + "_hat").camelize.constantize.new(:sprint => sprint, :text => params[:value])
    hat.save!

    render :status => 200, :partial => '/hats/'+params[:type], :locals => {:hat => hat}
  rescue ActiveRecord::RecordInvalid => ri
    render :status => 400, :text => 'Error adding hat: #{ri.to_s}'
  rescue NameError => ne
    render :status => 400, :text => 'Error adding hat: #{ne.to_s}'
  end

  def update
    id = params[:id].split('_').last
    field = params[:type] == "green" ? params[:id].split('_')[1] : 'text'

    sprint = current_user.sprints.find(params[:sprint_id])

    type = params[:type] == "green" ? "black" : params[:type]

    hat = (type + "_hat").camelize.constantize.find(:first, :conditions => {:id => id, :sprint_id => sprint.id})
    if params[:type] == 'green'
      if hat.green_hat
        hat = hat.green_hat
      else
        hat.green_hat = GreenHat.new
        hat = hat.green_hat
      end
    end

    hat.update_attributes!({field => params[:value]})

    render :status => 200, :text => params[:value]

  rescue ActiveRecord::RecordInvalid, NameError
    render :status => 400, :text => 'Error updating hat'
  rescue ActiveRecord::RecordNotFound
    render :status => 404
  end

  def promote
    sprint = current_user.sprints.find(params[:sprint_id])

    next_sprint = current_user.sprints.first(:conditions => {:end_date => nil})
    if next_sprint.blank? || next_sprint == sprint
      render :status => 400, :json => {:msg => 'Please Start a New Sprint'}.to_json
    else
      hat = sprint.black_hats.find(params[:id])
      hat.promotions = hat.promotions ? hat.promotions + 1 : 1
      next_sprint.black_hats << hat
      next_sprint.save
      render :status => 200, :json => {:msg => "Hat has been promoted to #{next_sprint.name}" }.to_json
    end


  end
end
