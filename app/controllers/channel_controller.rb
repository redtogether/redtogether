class ChannelController < ApplicationController

  def show
    @channel = Channel.find_by_name(params[:name])

    render status: 404 unless @channel
  end

  def submit

  end

end
