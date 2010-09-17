module EventsHelper 
  include ActionView::Helpers::DateHelper
  
  def format_event_date(date_string)
    now = Time.now
    "#{distance_of_time_in_words now, date_string} #{now > Time.parse(date_string) ? 'ago' : 'from now'}"
  end
  
	def body_attributes
    attributes = {:class => "#{body_classes.join(' ')}", :id => body_id}    
    attributes
  end
  
  def body_classes
    @body_classes ||= [self.body_class]
  end
  
  def add_body_class(clazz)
    self.body_classes << clazz
  end
  
  def body_class
    @controller.controller_name.dasherize
  end
  
  def body_id
    @controller.controller_name.dasherize + '-' + @controller.action_name.dasherize
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