module Databaseformalizer
  class Entity < ActiveRecord::Base
    set_table_name "databaseformalizer_entities"
    
    belongs_to :entity_def
  
    has_many  :attr_vals, :through => :attr_vals_entities
    has_many  :attr_vals_entities, :class_name => "AttrValsEntity"
    
    accepts_nested_attributes_for :attr_vals, :reject_if => lambda { |a| a[:value].blank? }, :allow_destroy => true

  end

end

# == Schema Information
#
# Table name: entities
#
#  id            :integer(4)      not null, primary key
#  label         :string(255)
#  description   :string(255)
#  entity_def_id :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

