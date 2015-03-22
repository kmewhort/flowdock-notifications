require 'flowdock'
require 'tmpdir'
require 'open-uri'

class FlowdockNotifications::FlowdockClient
  def initialize
    @client = Flowdock::Client.new(api_token: token)
  end

  def flow_names
    flows.map {|flow| flow['parameterized_name']}
  end

  def messages_since(flow_name, since_msg_id)
    @client.get("#{flow_url(flow_name)}/messages", since_id: since_msg_id)
  end

  def latest_message_id(flow_name)
    latest_msg = @client.get("#{flow_url(flow_name)}/messages", limit: 1).first
    latest_msg.nil? ? 0 : latest_msg['id']
  end

  def user(user_id)
    return nil if user_id.nil? || user_id == '0'
    @client.get "/users/#{user_id}"
  end

  def avatar(user_id)
    u = user(user_id)
    return nil if u.nil?

    url = u['avatar']
    return nil if url.nil? || url.empty?

    avatar_id = url.match(/\/([^\/]+)\/\Z/)[1]
    return nil if avatar_id.nil?

    # cached local copy of the avatar
    local_filename = "#{Dir.tmpdir}/#{avatar_id}"
    unless File.exists? local_filename
      File.open(local_filename, "wb") do |saved_file|
        open(url, "rb") {|read_file| saved_file.write(read_file.read)}
      end
    end
    local_filename
  end

  private
  def token
    ENV['FLOWDOCK_API_TOKEN'] or raise "Must configure FLOWDOCK_API_TOKEN in your environment variables"
  end

  def flows
    @flows ||= @client.get('/flows')
  end

  def flow(flow_name)
    flows.find {|f| f['parameterized_name'] == flow_name}
  end

  def flow_url(flow_name)
    f = flow(flow_name)
    "/flows/#{f['organization']['parameterized_name']}/#{f['parameterized_name']}"
  end
end