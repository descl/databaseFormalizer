module Databaseformalizer
  class AttrListJoinVal < ActiveRecord::Base
    set_table_name "databaseformalizer_attr_list_join_vals"
    belongs_to :attrJoinValChild, :foreign_key => "child_name_id", :class_name => "AttrVal"
    belongs_to :attrJoinValParent , :foreign_key => "parent_name_id" , :class_name => "AttrVal"
  end
end
# == Schema Information
#
# Table name: attr_list_join_vals
#
#  id             :integer(4)      not null, primary key
#  parent_name_id :integer(4)
#  child_name_id  :integer(4)
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

