require 'tmpdir'

class FlowdockNotifications::Notifier
  # send out notifications for new messages on throughout all flows
  def self.send
    store = FlowdockNotifications::SimpleStore.new
    client = FlowdockNotifications::FlowdockClient.new

    client.flow_names.each do |flow_name|
      # if there are no last retrieved messages, this must be the first run and there are no notifications yet:
      # simply store the latest message id so we can find new messages the next time
      flow_stored_vars = store.get(flow_name)
      last_id = flow_stored_vars ? flow_stored_vars['last_retrieved_id'] : nil
      unless last_id
        store.set(flow_name, { 'last_retrieved_id' => client.latest_message_id(flow_name) })
        next
      end

      new_messages = client.messages_since(flow_name, last_id)
      new_messages.each do |msg|
        notification = FlowdockNotifications::MessageNotification.new(client, flow_name, msg)
        notification.show!
      end

      unless new_messages.empty?
        store.set(flow_name, { 'last_retrieved_id' => new_messages.map {|m| m['id'].to_i}.max })
      end
    end
    true
  end
end