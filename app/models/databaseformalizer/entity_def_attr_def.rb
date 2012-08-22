module Databaseformalizer
  class EntityDefAttrDef < ActiveRecord::Base
    set_table_name "databaseformalizer_entity_def_attr_defs"
    belongs_to :entityDef, :foreign_key => "entity_def_name"
    belongs_to :attrDef, :foreign_key => "attr_def_name"
  end
end
# == Schema Information
#
# Table name: entity_def_attr_defs
#
#  id              :integer(4)      not null, primary key
#  entity_def_name :string(255)
#  attr_def_name   :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

