module Databaseformalizer
  class EntityDefsController < ApplicationController
    # GET /entity_defs
    # GET /entity_defs.json
    def index
      @entity_defs = EntityDef.all
      EntityDefsHelper.setMetaModelGraph("public/UMLmetaModel.png")
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @entity_defs }
      end
    end
  
    # GET /entity_defs/1
    # GET /entity_defs/1.json
    def show
      @entity_def = EntityDef.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @entity_def }
      end
    end
  
    # GET /entity_defs/new
    # GET /entity_defs/new.json
    def new
      @entity_def = EntityDef.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @entity_def }
      end
    end
  
    # GET /entity_defs/1/edit
    def edit
      @entity_def = EntityDef.find(params[:id])
    end
  
    # POST /entity_defs
    # POST /entity_defs.json
    def create
      @entity_def = EntityDef.new(params[:databaseformalizer_entity_def])
      if @entity_def.label == ""
        @entity_def.label = @entity_def.entity_def_name
      end
      respond_to do |format|
        if @entity_def.save
          format.html { redirect_to @entity_def, notice: 'Entity def was successfully created.'}
          format.json { render json: @entity_def, status: :created, location: @entity_def }
        else
          format.html { render action: "new" }
          format.json { render json: @entity_def.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /entity_defs/1
    # PUT /entity_defs/1.json
    def update
      @entity_def = EntityDef.find(params[:id])
      if params[:databaseformalizer_entity_def][:attrDef_ids] == nil
        @entity_def.attrDefs.clear
      end
      respond_to do |format|
        if @entity_def.update_attributes(params[:databaseformalizer_entity_def])
          format.html { redirect_to @entity_def, notice: 'Entity def was successfully updated.'  }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @entity_def.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /entity_defs/1
    # DELETE /entity_defs/1.json
    def destroy
      @entity_def = EntityDef.find(params[:id])
      @entity_def.destroy
  
      respond_to do |format|
        format.html { redirect_to databaseformalizer_entity_defs_url }
        format.json { head :no_content }
      end
    end
  end
end