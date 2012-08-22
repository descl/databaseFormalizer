module ActiveRecord
  module ActsAsEntity
    
    extend ActiveSupport::Concern
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def acts_as_entity(entityDef,options = {})
        after_initialize :setAttrs
        class << self
          alias_method :find_entities, :find#tester avec self??
        end
        include ActiveRecord::ActsAsEntity::InstanceMethods

        # create new class methods
        instance_eval <<-DEFINE_METHODS
          public
          def find(args)
            find_entities(args, :conditions =>  "entity_def_id = '#{entityDef}' ")
          end
          def all
            find_entities(:all, :conditions =>  "entity_def_id = '#{entityDef}' " )
          end
        DEFINE_METHODS
      end
    end
    
    module InstanceMethods
      
      #Used to initialize the parameters of an instance before read them in the child app
      def setAttrs( args = nil)
        self.attr_vals.each do |attrVal|
          
          #if attrVal.attrDef.dataType == 'entityDef' && ttrVal.attr_def_name.end_with('Id')
            #we add a virtual attr
          #  write_attribute(attrVal.attr_def_name.remove('Id'), Databaseformalizer::Entity.find(attrVal.value))
          #end
            
          #if the attribut already exist we add it to the list
          if read_attribute(attrVal.attr_def_name) != nil
            result = read_attribute(attrVal.attr_def_name)
            
            #we check if the result is a list of elements or just an item
            if result.class == Array
              result.push(attrVal.value)
            else
              tmp = result
              result = [tmp,attrVal.value]
            end

            write_attribute(attrVal.attr_def_name, result)
          else
            write_attribute(attrVal.attr_def_name, attrVal.value)
          end
        end
      end
      
      #update the instance elements attributs after edit on instances from the child app
      def update_attributes(attrs)
        #check if have an entity 
        #hard bug fix because update_attributes is launch for ALL items...
        if self.class.to_s.include? 'Databaseformalizer::'
          self.attributes = attrs
          save
        else
          for attr in attrs
            update_attribute(attr[0],attr[1])
          end
        end
      return true
      end
      #update the instance elements attributs after edit on instances from the child app
      def update_attribute(key,value)
        #check if have an entity 
        #hard bug fix because update_attributes is launch for ALL items...
        if self.class.to_s.include? 'Databaseformalizer::'
          self.attributes = attrs
          save
        else
                                                                                                                                   
          attrVal = self.attr_vals.find_by_attr_def_name(key)
          if attrVal == nil
            attrDef = Databaseformalizer::AttrDef.find(key);
            attrVal = Databaseformalizer::AttrVal.new(:attrDef => attrDef)
            self.attr_vals << attrVal
          end
          attrVal.value = value
          attrVal.save!
        end
      return true
      end
    end
  end
end

class ActiveRecord::Base
  include ActiveRecord::ActsAsEntity
end