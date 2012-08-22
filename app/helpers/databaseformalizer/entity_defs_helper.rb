module Databaseformalizer
  module EntityDefsHelper
    def EntityDefsHelper.setMetaModelGraph(uri )
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
      #g.edge[:dir]      = "forward"
      #g.edge[:arrowsize]= "0"
        
      nodesMap = {}
      @links = Array.new
      EntityDef.all.each do |entityDef|
        attrs = '';
        entityDef.attrDefs.each do |attrDef|
          if attrDef.dataType == "selectOneInList" || attrDef.dataType == "checkList" || attrDef.dataType == "openList"
            attrs += '+ '+attrDef.label+' : '+attrDef.dataType+'\l'
            childs =''
            attrDef.attrDefChilds.each do |child|
              childs += '+ '+child.label+' : '+child.childEntityDef.entity_def_name+' \n'
              link = [child.childEntityDef.entity_def_name, attrDef.label+'_enum']
              if !@links.include? link
                @links.push(link)
              end
            end
            enum = g.add_nodes( attrDef.label+'_enum', "shape" => "record", "label" => '{enumeration('+attrDef.label+')|'+childs+'}' )
            g.add_edges(enum,entityDef.entity_def_name, "arrowhead" => "vee" )
          elsif attrDef.dataType == "entityDef"
            if attrDef.childEntityDef != nil
              @links.push([attrDef.childEntityDef.entity_def_name,entityDef.entity_def_name])
              attrs += '+ '+attrDef.label+' : '+attrDef.childEntityDef.label+'\l'
            else
              attrs += '+ '+attrDef.label+' : null\l'
            end
          else
            attrs += '+ '+attrDef.label+' : '+attrDef.dataType+'\l'
          end
        end
        nodesMap[entityDef.entity_def_name] = g.add_nodes( entityDef.entity_def_name, "shape" => "record", "label" => '{'+(entityDef.label|| "")+'|'+attrs+'|}' )
      end
      
      @links.each do |link|
        edge = g.add_edges( link[0], link[1], "arrowhead" => "vee" )
  
        
      end
      # Generate output image
      g.output( :png => uri )
    end
  end
end