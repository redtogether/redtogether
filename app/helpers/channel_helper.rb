module ChannelHelper
  def channel_link(channel)
    link_to "+#{channel.name}", channel_path(channel)
  end
end
