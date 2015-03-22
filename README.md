# Flowdock::Notifications

This gem provides cross-platform message notifications for flowdock (through libnotify on linux, growl on mac). Currently only
supports showing all messages across all flows.

## Installation

Install the gem globally:

    $ gem install flowdock-notifications

Add `FLOWDOCK_API_TOKEN=<your flowdock api token>` to your environment variables.

Then run `bin/flowdock-notifications' as periodic as you'd like to receive messages (eg. every 30 seconds) from your cron.

## Contributing

1. Fork it ( https://github.com/kmewhort/flowdock-notifications/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
