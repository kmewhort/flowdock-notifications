# simple JSON variable store to a tempfile
require 'json'
class FlowdockNotifications::SimpleStore
  def initialize
    if File.exists?(temp_filename) && File.size(temp_filename) > 0
      @store = JSON.parse(IO.read(temp_filename))
    else
      @store = {}
    end
  end

  def get(variable)
    @store[variable]
  end

  def set(variable, value)
    @store[variable] = value
    File.open(temp_filename, "w") { |f| f.write(@store.to_json) }
  end

  private
  def temp_filename
     "#{Dir.tmpdir}/flowdock-notifications.json"
  end
end