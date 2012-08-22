module Databaseformalizer
  class AttrListJoinDef < ActiveRecord::Base
    set_table_name "databaseformalizer_attr_list_join_defs"
    belongs_to :attrJoinDefChild, :foreign_key => "child_name", :class_name => "AttrDef"
    belongs_to :attrJoinDefParent , :foreign_key => "parent_name" , :class_name => "AttrDef"
  end
end
# == Schema Information
#
# Table name: attr_list_join_defs
#
#  parent_name :string(255)     not null
#  child_name  :string(255)     not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

