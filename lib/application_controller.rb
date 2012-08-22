module Databaseformalizer
  ## Define ControllerMethods
  module Controller
  	## this one manages the usual self.included, klass_eval stuff
    extend ActiveSupport::Concern
  	included do
      before_filter :set_special_layout_databaseformalizer
    end
    
    def set_special_layout_databaseformalizer
      module_name = self.class.name.split("::").first
      if module_name == 'Databaseformalizer'
        self.class.layout "databaseformalizer/layouts/application"
      end
    end

  end
end
::ActionController::Base.send :include, Databaseformalizer::Controller


