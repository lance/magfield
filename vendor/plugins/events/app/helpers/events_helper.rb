module EventsHelper 
  include ActionView::Helpers::DateHelper
  
  def format_event_date(event)
    now = Time.now
    start_date = Time.parse(event.start_date)
    end_date = event.end_date.nil? ? nil : Time.parse(event.end_date)

    if (start_date <= now && end_date)
      "continuing for #{distance_of_time_in_words(now, end_date)}"
    else
      "#{distance_of_time_in_words now, event.start_date} #{now > Time.parse(event.start_date) ? 'ago' : 'from now'}"
    end
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
      self.load_events if (@@event_cache.blank? || (self.last_update < 5.minutes.ago))
      @@event_cache[:events]
    end
    
    def self.last_update
      @@event_cache[:updated]
    end
    
    def self.load_events
      begin
        @@event_cache = {:updated=>Time.now, :events=>EventBright::User.new(EVENT_BRIGHT_USER_KEY).events[0..6].select {|e|DateTime.parse(e.end_date) > Time.now}}      
      rescue EventBright::Error => e
        puts "Cannot load events: #{e.message}"
      end
    end
    
    @@event_cache = {};
  end  
end

Shovelpunks::Events.load_events
