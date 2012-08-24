module Databaseformalizer
  class AttrVal < ActiveRecord::Base
    set_table_name "databaseformalizer_attr_vals"
    attr_accessible :attrDef
    belongs_to :attrDef, :foreign_key => "attr_def_name", :class_name => "AttrDef"
    
    has_many :attrValsEntities, :class_name => "AttrValsEntity"#, :source => :attr_val
    has_many :entities, :through => :attrValsEntities
    
    #getting parent Attribut
    has_many :attrValParents, :through => :attrListJoinVal, :source => :attrJoinValParent
    has_many :attrListJoinVal, :foreign_key => "child_name_id", :class_name => "AttrListJoinVal"
    
    #gettind childs (only for AttrListDef)
    has_many  :attrValChilds, :through => :attrJoinValChild, :source => :attrJoinValChild
    has_many :attrJoinValChild, :foreign_key => "parent_name_id", :class_name => "AttrListJoinVal"
  end
#  def AttrVal.get_or_create_attrVal(attrDef)
#    attrVal = self.find_by_attr_def_name(attrDef)
#    if attrVal == nil
#      attrVal = AttrVal.new
#    end
#    attrVal
#  end

end

# == Schema Information
#
# Table name: attr_vals
#
#  id            :integer(4)      not null, primary key
#  value         :string(255)
#  attr_def_name :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#