ActionController::Routing::Routes.draw do |map|
  map.resources :events

  map.namespace(:admin, :path_prefix => 'refinery') do |admin|
    admin.resources :events, :collection => {:update_positions => :post}
  end
end
