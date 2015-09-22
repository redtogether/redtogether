class ChannelController < ApplicationController

  def show
    @channel = Channel.find_by_name(params[:name])

    render status: 404 unless @channel
  end

  def subscribe
    @channel = Channel.find_by_name(params[:name])

    if current_user.subscribe(@channel)
      flash[:notice] = "Subscribed to #{@channel.name}"
    else
      flash[:alert] = "Already subscribed to #{@channel.name}!"
    end

    redirect_to @channel
  end

  def unsubscribe
    @channel = Channel.find_by_name(params[:name])

    if current_user.unsubscribe(@channel)
      flash[:notice] = "Unubscribed from #{@channel.name}"
    else
      flash[:alert] = "Already unsubscribed from #{@channel.name}!"
    end
    
    redirect_to @channel
  end

end
