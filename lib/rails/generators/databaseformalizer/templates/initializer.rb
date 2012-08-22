module Databaseformalizer
  class Engine < Rails::Engine

    config.mount_at = '/databaseformalizer'
    config.widget_factory_name = 'Factory Name'
        
  end
end
