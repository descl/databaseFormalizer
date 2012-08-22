module Databaseformalizer
  class EntitiesController < ApplicationController
    include Databaseformalizer

    # GET /entities
    # GET /entities.json
    def index
      @entities = Entity.find(:all, :limit=>100)
      EntitiesHelper.setModelGraph("public/images/UMLmodel.png")
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @entities }
      end
    end
  
    # GET /entities/1
    # GET /entities/1.json
    def show
      @entity = Entity.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @entity }
      end
    end
  
    # GET /entities/new
    # GET /entities/new.json
    def new
      @entity = Entity.new
      
      if params[:entity_def] != nil
        @all_entityDefs = EntityDef.find_all_by_entity_def_name(params[:entity_def])
        @entity.entity_def = @all_entityDefs.first
        @type = params[:entity_def]
      else
        @all_entityDefs = EntityDef.all
        @type = "Entity"
      end
      respond_to do |format|
        format.html # new.html.erbe
        format.json { render json: @entity }
        format.js { @entity }
      end
    end
  
    # GET /entities/1/edit
    def edit
      @entity = Entity.find(params[:id])
      @all_entityDefs = EntityDef.all
    end
  
    # POST /entities
    # POST /entities.json
    def create
      @entity = Entity.new(params[:databaseformalizer_entity])
      @entity.attr_vals.clear
      EntitiesHelper.setAttrVals(params[:attr_vals], @entity)
      
      respond_to do |format|
        if @entity.save
          format.html { redirect_to @entity, notice: 'Entity was successfully created.' }
          format.json { render json: @entity, status: :created, location: @entity }
        else
          format.html { render action: "new" }
          format.json { render json: @entity.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /entities/1
    # PUT /entities/1.json
    def update
      @entity = Entity.find(params[:id])
      @entity.attr_vals.clear
      EntitiesHelper.setAttrVals(params[:attr_vals], @entity)
      @entity.attributes = params[:databaseformalizer_entity]
      
      respond_to do |format|
        if @entity.save
          format.html { redirect_to @entity, notice: 'Entity was successfully updated.'}
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @entity.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /entities/1
    # DELETE /entities/1.json
    def destroy
      
      @entity = Entity.find(params[:id])
      @entity.destroy
  
      respond_to do |format|
        format.html { redirect_to databaseformalizer_entities_url }
        format.json { head :no_content }
      end
    end
  
  end
end