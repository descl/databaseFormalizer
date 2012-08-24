module Databaseformalizer
  class AttrDef < ActiveRecord::Base
    set_table_name "databaseformalizer_attr_defs"
    set_primary_key :attr_def_name
    attr_accessible :attr_def_name, :label, :description, :mandatory, :category, :dataType, :attrDefChild_ids, :child_entity_def_name
    
    #Getting Entity
    has_many :entityDefs, :through => :entityDefAttrDefs
    has_many :entityDefAttrDefs, :foreign_key => "attr_def_name"
    
    
    #getting parent Attribut
    has_many :attrDefParents, :through => :attrJoinDefParent, :source => :attrJoinDefParent
    has_many :attrJoinDefParent, :foreign_key => "child_name", :class_name => "AttrListJoinDef"
    
    #getting childs (only for AttrListDef)
    has_many  :attrDefChilds, :through => :attrJoinDefChild, :source => :attrJoinDefChild
    has_many :attrJoinDefChild, :foreign_key => "parent_name", :class_name => "AttrListJoinDef"
    
    #gettin the entity def attribut
    belongs_to :childEntityDef, :foreign_key => "child_entity_def_name", :class_name => "EntityDef"
  end
  
  #class AttrListDef < AttrDef
    #getting childs
  #  has_many  :attrDefChilds, :through => :attrListJoinDefs
  #  has_many :attrListJoinDefs, :foreign_key => "attrDef_name"
  #end
  
  #class AttrSimpleDef < AttrDef
  
  #end
  
  # == Schema Information
  #
  # Table name: attr_defs
  #
  #  attr_def_name         :string(255)     primary key
  #  label                 :string(255)
  #  description           :string(255)
  #  mandatory             :boolean(1)
  #  category              :string(255)
  #  dataType              :string(255)
  #  created_at            :datetime        not null
  #  updated_at            :datetime        not null
  #  child_entity_def_name :string(255)
  #
end
