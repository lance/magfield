module EventsHelper 
  include ActionView::Helpers::DateHelper

  def format_event_date(event)
    start_date = Time.parse(event.start_date)
    end_date = event.end_date.nil? ? nil : Time.parse(event.end_date)

    if start_date.today?
      return "Today at #{start_date.strftime('%I:%M %p')}"
    end

    if (start_date <= time_now && end_date)
      "now through #{end_date}"
    else
      start_date.strftime('%B %d at %I:%M %p')
    end
  end

  def short_date(event)
    start_date = Time.parse(event.start_date)
    start_date.strftime('%m/%d @%I:%M')
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

def time_now
  Time.now + 18000 # Account for UTC on purplecat servers
end
  

module Shovelpunks
  module Events
    def self.upcoming
      self.load_events if (@@event_cache.blank? || (self.last_update < 5.minutes.ago))
      @@event_cache[:events][0..13]
    end

    def self.listings
      self.load_events if (@@event_cache.blank? || (self.last_update < 5.minutes.ago))
      @@event_cache[:events]
    end
    
    def self.last_update
      @@event_cache[:updated]
    end
    
    def self.load_events
      begin
        @@event_cache = {:updated=>time_now, :events=>EventBright::User.new(EVENT_BRIGHT_USER_KEY).events.select {|e|(DateTime.parse(e.end_date) > Date.today) && (e.status != "Draft")}}      
      rescue EventBright::Error => e
        puts "Cannot load events: #{e.message}"
      end
    end
    
    @@event_cache = {};
  end  
end

Shovelpunks::Events.load_events
