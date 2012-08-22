require 'databaseformalizer'
require 'rails'
require 'action_controller'
require 'application_helper'

module Databaseformalizer
  class Engine < Rails::Engine
    # Config defaults
    config.widget_factory_name = "dbformalizer factory"
    config.mount_at = '/databaseformalizer'
    
    # Load rake tasks
    rake_tasks do
      load File.join(File.dirname(__FILE__), 'rails/railties/tasks.rake')
    end
    
    
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

  end
end
