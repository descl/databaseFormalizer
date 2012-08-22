module Databaseformalizer
  require 'acts_as_entity/base'
  #the engine and controller need to be load with path in order to not load the parent plugin engine
  require File.expand_path('../engine', __FILE__)
  require File.expand_path('../application_controller', __FILE__)

  module Databaseformalizer

  end
  

  #we define the routes there
  def extraRoutes(map)
    mount_at =  '/databaseformalizer'
    map.with_options(:path_prefix => mount_at, :name_prefix => "databaseformalizer_") do |t|
      t.resources :entities,    :controller => "databaseformalizer/entities"
      t.resources :entity_defs, :controller => "databaseformalizer/entity_defs"
      t.resources :attr_defs,   :controller => "databaseformalizer/attr_defs"
    end 
       
    map.databaseformalizer 'databaseformalizer', 
        :action => 'index', 
        :controller => 'databaseformalizer/dbformahome'

  end
  module_function :extraRoutes
end
