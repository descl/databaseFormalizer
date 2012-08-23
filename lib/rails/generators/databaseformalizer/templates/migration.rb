class CreateDatabaseformalizerTables < ActiveRecord::Migration
  def self.up
    
   # create_table :databaseformalizer_widgets, :force => true do |t|
   #   t.string    :title
   #   t.datetime  :created_at
   #   t.datetime  :updated_at
   # end
   #
   # add_index :databaseformalizer_widgets, [:title]
    
    
  create_table :databaseformalizer_attr_defs, :id => false, :force => true do |t|
    t.string   "attr_def_name"
    t.string   "label"
    t.string   "description"
    t.boolean  "mandatory"
    t.string   "category"
    t.string   "dataType"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "child_entity_def_name"
  end
  add_index :databaseformalizer_attr_defs, ["attr_def_name"], :name => "index_attr_defs_on_attr_def_name", :unique => true

  create_table :databaseformalizer_attr_list_join_defs, :id => false, :force => true do |t|
    t.string   "parent_name", :null => false
    t.string   "child_name",  :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end
  add_index :databaseformalizer_attr_list_join_defs, ["parent_name", "child_name"], :name => "index_attr_list_join_defs_on_parent_name_and_child_name", :unique => true

  create_table :databaseformalizer_attr_list_join_vals, :force => true do |t|
    t.integer  "parent_name_id"
    t.integer  "child_name_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end
  add_index :databaseformalizer_attr_list_join_vals, ["child_name_id"], :name => "index_attr_list_join_vals_on_child_name_id"
  add_index :databaseformalizer_attr_list_join_vals, ["parent_name_id"], :name => "index_attr_list_join_vals_on_parent_name_id"

  create_table :databaseformalizer_attr_vals, :force => true do |t|
    t.string   "value"
    t.string   "attr_def_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table :databaseformalizer_attr_vals_entities, :id => false, :force => true do |t|
    t.integer  "entity_id"
    t.integer  "attr_val_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end
  add_index :databaseformalizer_attr_vals_entities, ["entity_id", "attr_val_id"], :name => "index_attr_vals_entities_on_entity_id_and_attr_val_id"

  create_table :databaseformalizer_entities, :force => true do |t|
    t.string   "label"
    t.string   "description"
    t.string   "entity_def_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end
  add_index :databaseformalizer_entities, ["entity_def_id"], :name => "index_entities_on_entity_def_id"

  create_table :databaseformalizer_entity_def_attr_defs, :force => true do |t|
    t.string   "entity_def_name"
    t.string   "attr_def_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end
  add_index :databaseformalizer_entity_def_attr_defs, ["attr_def_name"], :name => "index_entity_def_attr_defs_on_attr_def_name"
  add_index :databaseformalizer_entity_def_attr_defs, ["entity_def_name"], :name => "index_entity_def_attr_defs_on_entity_def_name"

  create_table :databaseformalizer_entity_defs, :id => false, :force => true do |t|
    t.string   "entity_def_name", :null => false
    t.string   "label"
    t.string   "description"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end
  add_index :databaseformalizer_entity_defs, ["entity_def_name"], :name => "index_entity_defs_on_entity_def_name", :unique => true


  end

  def self.down

  end
end
