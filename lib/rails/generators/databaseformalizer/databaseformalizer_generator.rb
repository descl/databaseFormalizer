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

  def update_application_template
    f = File.open "app/views/layouts/application.html.erb"
    layout = f.read; f.close

  end
  
end
