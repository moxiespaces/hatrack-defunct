class HatsController < ApplicationController
  before_filter :authenticate_user!

  def create
    sprint = current_user.sprints.find(params[:sprint_id])

    hat = (params[:type] + "_hat").camelize.constantize.new(:sprint => sprint, :text => params[:value])
    hat.save!

    render :status => 200, :partial => '/hats/'+params[:type], :locals => {:hat => hat}
  rescue ActiveRecord::RecordInvalid => ri
    render :status => 400, :text => 'Error adding hat: #{ri.to_s}'
  end

  def update
    id = params[:id].split('_').last

    sprint = current_user.sprints.find(params[:sprint_id])

    hat = case params[:type]
      when 'yellow'
        sprint.yellow_hats.find(id)
      when 'black'
        sprint.black_hats.find(id)
      when 'green'
        black_hat = sprint.black_hats.find(id)
        unless black_hat.green_hat
          black_hat.green_hat = GreenHat.new()
        end
        black_hat.green_hat
    end

    hat.text = params[:value]

    if sprint.save
      render :status => 200, :text => params[:value]
    else
      render :status => 400, :text => 'Error updating hat'
    end
  end

  def update_green_hat
    hat_data =  params[:id].split('_')
    id = hat_data.last
    field = hat_data[1]

    sprint = Sprint.find(params[:sprint_id])

    black_hat = sprint.black_hats.find(id)
    unless black_hat.green_hat
      black_hat.green_hat = GreenHat.new()
    end

    black_hat.green_hat[field] = params[:value]

    if sprint.save
      render :status => 200, :text => params[:value]
    else
      render :status => 400, :text => 'Error updating hat'
    end

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
