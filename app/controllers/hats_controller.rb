class HatsController < ApplicationController

  def create
    sprint = Sprint.find(params[:sprint_id])

    lo = {:text => params[:value]}
    
    case params[:type]
      when 'yellow'
        hat = YellowHat.new(lo)
        sprint.yellow_hats << hat
      when 'black'
        hat = BlackHat.new(lo)
        sprint.black_hats << hat
    end

    logger.info sprint.inspect
    logger.info hat.inspect
    if sprint.save
      render :status => 200, :partial => '/hats/'+params[:type], :locals => {:hat => hat}
    else
      render :status => 400, :text => 'Error adding hat'
    end
  end

  def update
    id = params[:id].split('_').last

    sprint = Sprint.find(params[:sprint_id])

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
    logger.info hat.inspect
    hat.text = params[:value]
    logger.info hat.inspect
    if sprint.save
      render :status => 200, :text => params[:value]
    else
      render :status => 400, :text => 'Error updating hat'
    end
  end

end
