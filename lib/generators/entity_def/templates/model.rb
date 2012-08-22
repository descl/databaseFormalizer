class <%= singular_name.camelize %> < Databaseformalizer::Entity
  acts_as_entity :<%= singular_name.camelize %>
end
