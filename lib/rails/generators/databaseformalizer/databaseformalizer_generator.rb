require 'rails/generators'
require 'rails/generators/migration'

class DatabaseformalizerGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
   
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end


  # Every method that is declared below will be automatically executed when the generator is run
  
  def create_migration_file
    migration_template  'migration.rb',
                        'db/migrate/create_databaseformalizer_tables.rb'
  end

  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/databaseformalizer.rb'
  end

  def add_databaseformalizer_routes
    dbfo_route = "mount_at =  '/databaseformalizer'
    with_options(:path_prefix => mount_at, :name_prefix => 'databaseformalizer_') do |t|
      t.resources :entities,    :controller => 'databaseformalizer/entities'
      t.resources :entity_defs, :controller => 'databaseformalizer/entity_defs'
      t.resources :attr_defs,   :controller => 'databaseformalizer/attr_defs'
    end 
       
    match 'databaseformalizer',# :to => 'databaseformalizer/dbformahome#index'
        :action => 'index', 
        :controller => 'databaseformalizer/dbformahome'"
    route dbfo_route
  end
end
