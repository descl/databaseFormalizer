module Databaseformalizer
  module EntitiesHelper
    def EntitiesHelper.initAttrVals(entity)
      entityDef = entity.entity_def
      
      entityDef.attrDefs.each do |attrDef|
        attrVal = AttrVal.new(:attrDef => attrDef)
        entity.attr_vals << attrVal
        attrVal.save
      end
    end
    def EntitiesHelper.setAttrVals(params, entity, parent = nil )

      if params == nil; params = []; end   
      params.each do |attrType,attrFormValue|
        attrDef = AttrDef.find(attrType);
        attrVal =  entity.attr_vals.find_by_attr_def_name(attrType)
        #check if item exist or if is in an insert or update
        if attrVal == nil || (attrVal != nil && parent != nil && parent.attrDef.dataType == "openList" )
          attrVal = AttrVal.new(:attrDef => attrDef)
          entity.attr_vals << attrVal
          if parent != nil
            parent.attrValChilds << attrVal
          end
        end

        case attrVal.attrDef.dataType
          when "String"
            attrVal.value = attrFormValue
          when "Date"
            attrVal.value = "25/10/2010"
          when "aChoice"
            attrVal.value = "selected"
          when "checkList"
            #first, we remove unselected items
            attrFormValue.reject!{ |k,val| val == "0" }
            EntitiesHelper.setAttrVals(attrFormValue, entity, attrVal)
            attrVal.value = "isList"
          when "selectOneInList"
            EntitiesHelper.setAttrVals({ attrFormValue => 1 }, entity, attrVal)
            attrVal.value = "isList"
          when "openList"
            attrFormValue.delete("_destroy")
            map = attrFormValue.map{|a| [a[0][0..-14], a[1]]}

            EntitiesHelper.setAttrVals(map, entity, attrVal)
            attrVal.value = "isList"
          when "entityDef"
            attrVal.value = attrFormValue
          else
            attrVal.value = attrFormValue
        end
        attrVal.save
      end
    end

    def EntitiesHelper.removeAttrVals(params, entity)
      if params == nil; params = []; end   
      params.each do |attrType,attrFormValue|
        attrDef = AttrDef.find(attrType);
        attrVal =  entity.attr_vals.find_all_by_attr_def_name(attrType)
        if attrVal.size > 1
          attrVal = entity.attr_vals.find(:first, :conditions => ["attr_def_name = ? and value = ?", attrType, attrFormValue])
        else
          attrVal = attrVal[0]
        end
        case attrVal.attrDef.dataType
        when "String" || "Date" || "aChoice"
            attrVal.destroy
          when "checkList"
            EntitiesHelper.removeAttrVals(attrFormValue, entity)
            attrVal.destroy
          when "selectOneInList"
            #TODO implement
          when "openList"
            attrFormValue.delete("_destroy")
            map = attrFormValue.map{|a| [a[0][0..-14], a[1]]}

            EntitiesHelper.removeAttrVals(map, entity)
            attrVal.value = "isList"
          when "entityDef"
            attrVal.destroy
        end
      end
    end
    
    def link_to_add_attrlistvalue(name, f,  parent)
      #fields = f.fields_for parent.id do |builder|
        fields = render("attr_val_openList_element_form", :f => f,  :parent => parent)
      #end
      link_to_function(name, "add_attrlistvalues(this, \"#{parent.attr_def_name}\", \"#{escape_javascript(fields)}\")")
    end
    
    def EntitiesHelper.setModelGraph(uri )
      require 'graphviz'
      # Create a new graph
      g = GraphViz.new( :G, :type => :digraph )
      
      # Graph configuration
      g.node[:color]    = "#ddaa66"
      g.node[:style]    = "filled"
      g.node[:shape]    = "box"
      g.node[:penwidth] = "1"
      g.node[:fontname] = "Trebuchet MS"
      g.node[:fontsize] = "8"
      g.node[:fillcolor]= "#ffeecc"
      g.node[:fontcolor]= "#000000"
      g.node[:margin]   = "0.05"
      
      # set global edge options
      g.edge[:color]    = "#999999"
      g.edge[:weight]   = "1"
      g.edge[:fontsize] = "6"
      g.edge[:fontcolor]= "#444444"
      g.edge[:fontname] = "Verdana"
      
      # Create two nodes
      nodesMap = {}
      @links = Array.new
      Entity.all.each do |entity|
        if entity.entity_def == nil
          next
        end
        attrs = '';
        entity.attr_vals.each do |attrVal|
          if attrVal.attrDef.dataType == "entityDef"
            #we need to add a link
            if attrVal.attrDef.childEntityDef != nil
              @links.push([attrVal.value,entity.id.to_s])
              begin
                attrs += attrVal.attrDef.label+':'+attrVal.attrDef.dataType+'="'+CGI.escapeHTML(attrVal.value)+'"\l'
              rescue
              end
            else
              attrs += '+ '+attrVal.attrDef.label+' : null\l'
            end
          else
            begin
              attrs += attrVal.attrDef.label+':'+attrVal.attrDef.dataType+'="'+CGI.escapeHTML(attrVal.value)+'"\l'
            rescue
            end
          end
        end
        begin
          nodesMap[entity.id.to_s] = g.add_nodes( entity.id.to_s, "shape" => "record", "label" => '{'+entity.label+':'+entity.entity_def.id.to_s+'|'+attrs+'}' )
          g.add_nodes( entity.id.to_s,"shape" => "record", "label" => '{'+entity.label+':'+entity.entity_def.id.to_s+'|'+attrs+'}' )
        rescue
        end
      end
      @links.each do |link|
        begin
          g.add_edges( nodesMap[link[0]], nodesMap[link[1]])
        rescue
        end
      end
      # Generate output image
      g.output( :png => uri )
    end
  end
end