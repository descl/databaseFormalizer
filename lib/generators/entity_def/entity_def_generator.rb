require 'rails/generators'
require 'rails/generators/named_base'

class String
  def snake_case
    return downcase if match(/\A[A-Z]+\z/)
    gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
    gsub(/([a-z])([A-Z])/, '\1_\2').
    downcase
  end
  
end

class EntityDefGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)



  def manifest
    lower_name = class_name[0, 1].downcase + class_name[1..-1]
    high_name = class_name[0, 1].upcase + class_name[1..-1]
    singular_name = lower_name.singularize
    plural_name = class_name.pluralize
    snake_name = lower_name.pluralize.snake_case
    
    template  "controller.rb", File.join(["app/controllers/", "#{snake_name}_controller.rb"].flatten)
    template  "helper.rb", File.join(["app/helpers/", "#{snake_name}_helper.rb"].flatten)
    template  "model.rb",  File.join(["app/models/", "#{singular_name.snake_case}.rb"].flatten)
    
    empty_directory File.join("app/views", snake_name)
    template  "view/_form.html.erb",  File.join(["app/views/#{snake_name}/", "_form.html.erb"].flatten)
    template  "view/edit.html.erb",   File.join(["app/views/#{snake_name}/", "edit.html.erb"].flatten)
    template  "view/index.html.erb",  File.join(["app/views/#{snake_name}/", "index.html.erb"].flatten)
    template  "view/new.html.erb",    File.join(["app/views/#{snake_name}/", "new.html.erb"].flatten)
    template  "view/show.html.erb",   File.join(["app/views/#{snake_name}/", "show.html.erb"].flatten)
    
    route     "resources :#{snake_name}"
  end
end