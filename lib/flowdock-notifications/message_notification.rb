require 'notify'
require 'json'

class FlowdockNotifications::MessageNotification
  def initialize(client, flow_name, message)
    @message = message
    @flow_name = flow_name
    @client = client
  end

  def show!
    Notify.notify title, content, options
  end

  protected
  def options
    opts = {
        app_name: "flowdock-notifications"
    }
    opts[:icon] = icon if icon
    opts
  end

  def title
    return @title if @title
    user = @client.user(@message['user'])
    @title ||= "[#{@flow_name}] #{user.nil? ? '' : user['nick']}"
  end

  def content
    return nil if @message['content'].nil?

    if @message['content'].is_a? String
      @message['content']
    elsif @message['content']['subject']
      @message['content']['subject']
    elsif @message['content']['content']
      @message['content']['content']
    else
      @message['content'].to_json
    end
  end

  def icon
    @icon ||= @client.avatar(@message['user'])
  end
end
