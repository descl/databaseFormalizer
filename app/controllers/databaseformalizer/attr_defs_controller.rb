module Databaseformalizer
  class AttrDefsController < ApplicationController
    # GET /attr_defs
    # GET /attr_defs.json
    def index
      @attr_defs = AttrDef.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @attr_defs }
      end
    end
  
    # GET /attr_defs/1
    # GET /attr_defs/1.json
    def show
      @attr_def = AttrDef.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @attr_def }
      end
    end
  
    # GET /attr_defs/new
    # GET /attr_defs/new.json
    def new
      @attr_def = AttrDef.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @attr_def }
      end
    end
  
    # GET /attr_defs/1/edit
    def edit
      @attr_def = AttrDef.find(params[:id])
    end
  
    # POST /attr_defs
    # POST /attr_defs.json
    def create
      @attr_def = AttrDef.new(params[:databaseformalizer_attr_def])
      if @attr_def.label == ""
        @attr_def.label = @attr_def.attr_def_name
      end
      
      if params[:databaseformalizer_attr_def]['dataType'] == "entityDef"
        @attr_def.child_entity_def_name=params[:databaseformalizer_attr_def]['child_entity_def_name']
      else
        @attr_def.child_entity_def_name=nil
      end
  
      respond_to do |format|
        if @attr_def.save
          format.html { redirect_to @attr_def, notice: 'Attr def was successfully created.' }
          format.json { render json: @attr_def, status: :created, location: @attr_def }
        else
          format.html { render action: "new" }
          format.json { render json: @attr_def.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /attr_defs/1
    # PUT /attr_defs/1.json
    def update
      @attr_def = AttrDef.find(params[:id])
      if params[:databaseformalizer_attr_def]['dataType'] == "entityDef"
        @attr_def.child_entity_def_name=params[:databaseformalizer_attr_def]['child_entity_def_name']
      else
        @attr_def.child_entity_def_name=nil
      end
      respond_to do |format|
        if @attr_def.update_attributes(params[:databaseformalizer_attr_def])
          format.html { redirect_to @attr_def, notice: 'Attr def was successfully updated.'}
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @attr_def.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /attr_defs/1
    # DELETE /attr_defs/1.json
    def destroy
      @attr_def = AttrDef.find(params[:id])
      @attr_def.destroy
  
      respond_to do |format|
        format.html { redirect_to databaseformalizer_attr_defs_url }
        format.json { head :no_content }
      end
    end
  end
end