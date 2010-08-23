class Admin::EventsController < Admin::BaseController

  # crudify :event, :title_attribute => :title
  def index
    @events = []
  end

end
