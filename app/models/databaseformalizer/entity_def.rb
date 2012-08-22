module Databaseformalizer
  class EntityDef < ActiveRecord::Base
    set_table_name "databaseformalizer_entity_defs"
    set_primary_key :entity_def_name
    attr_accessible :entity_def_name, :label, :description, :attrDef_ids
    
    has_many  :attrDefs, :through => :entityDefAttrDefs
    has_many  :entityDefAttrDefs, :foreign_key => "entity_def_name", :dependent => :delete_all
    #dele_all just for the liaison table
    
    has_many  :entities, :dependent => :delete_all
    #has_many  :childAttrDefs, :foreign_key => "child_entity_def_name"
  end
end
# == Schema Information
#
# Table name: entity_defs
#
#  entity_def_name :string(255)     not null, primary key
#  label           :string(255)
#  description     :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

