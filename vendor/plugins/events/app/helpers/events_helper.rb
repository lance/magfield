module EventsHelper 
  include ActionView::Helpers::DateHelper
  def format_event_date(date_string)
    distance_of_time_in_words Time.now, date_string
  end
  
end

module Shovelpunks
  module Events
    def self.upcoming
      self.load_events if (@@event_cache.blank? || self.last_update < 30.minutes.ago)
      @@event_cache[:events]
    end
    
    def self.last_update
      @@event_cache[:updated]
    end
    
    def self.load_events
      begin
        @@event_cache = {:updated=>Time.now, :events=>EVENT_BRIGHT_USER.events[0..6]}      
      rescue EventBright::Error => e
        puts "Cannot load events: #{e.message}"
      end
    end
    
    @@event_cache = {};
  end  
end

Shovelpunks::Events.load_events