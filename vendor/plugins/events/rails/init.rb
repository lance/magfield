Refinery::Plugin.register do |plugin|
  plugin.name = "events"
  plugin.activity = {
    :class => Event}

  plugin.directory = directory # tell refinery where this plugin is located
end
