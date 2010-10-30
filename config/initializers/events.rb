require 'eventbright'

EVENT_BRIGHT_APP_KEY  = "ZTgyNjQwZjQ0YzM5"
EVENT_BRIGHT_USER_KEY = "12882761037925815327"

begin
  EventBright.setup(EVENT_BRIGHT_APP_KEY)
  EVENT_BRIGHT_USER     = EventBright::User.new(EVENT_BRIGHT_USER_KEY)
rescue Error => e
  puts "Cannot load events from Eventbright: #{e.message}"
end