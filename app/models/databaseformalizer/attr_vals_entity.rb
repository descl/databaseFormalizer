module Databaseformalizer
  class AttrValsEntity < ActiveRecord::Base
    set_table_name "databaseformalizer_attr_vals_entities"
    belongs_to :entity, :foreign_key => "entity_id"
    belongs_to :attr_val, :foreign_key => "attr_val_id"
  end
end

# == Schema Information
#
# Table name: attr_vals_entities
#
#  entity_id   :integer(4)
#  attr_val_id :integer(4)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

