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
    dbfo_route = "Databaseformalizer.extraRoutes(map)"
    route dbfo_route
  
    sentinel = 'Application.routes.draw do
'
    begin
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "Application.routes.draw do |map|
"
      end
    rescue
    end
  end
end
