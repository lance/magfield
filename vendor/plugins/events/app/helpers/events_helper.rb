module EventsHelper 
  def format_event_date(date_string)
    date_string
  end
  
end

module Shovelpunks
  module Events
    def self.upcoming
      self.load_events if self.last_update < 30.minutes.ago
      @@event_cache[:events]
    end
    
    def self.last_update
      @@event_cache[:updated]
    end
    
    def self.load_events
      @@event_cache = {:updated=>Time.now, :events=>EVENT_BRIGHT_USER.events[0..4]}      
    end
    
    @@event_cache = self.load_events
  end  
end