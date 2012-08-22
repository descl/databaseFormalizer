module Databaseformalizer
  class AttrValsController < ApplicationController
    # GET /attr_vals
    # GET /attr_vals.json
    def index
      @attr_vals = AttrVal.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @attr_vals }
      end
    end
  
    # GET /attr_vals/1
    # GET /attr_vals/1.json
    def show
      @attr_val = AttrVal.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @attr_val }
      end
    end
  
    # GET /attr_vals/new
    # GET /attr_vals/new.json
    def new
      @attr_val = AttrVal.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @attr_val }
      end
    end
  
    # GET /attr_vals/1/edit
    def edit
      @attr_val = AttrVal.find(params[:id])
    end
  
    # POST /attr_vals
    # POST /attr_vals.json
    def create
      @attr_val = AttrVal.new(params[:databaseformalizer_attr_val])
  
      respond_to do |format|
        if @attr_val.save
          format.html { redirect_to @attr_val, notice: 'Attr val was successfully created.' }
          format.json { render json: @attr_val, status: :created, location: @attr_val }
        else
          format.html { render action: "new" }
          format.json { render json: @attr_val.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /attr_vals/1
    # PUT /attr_vals/1.json
    def update
      @attr_val = AttrVal.find(params[:id])
  
      respond_to do |format|
        if @attr_val.update_attributes(params[:databaseformalizer_attr_val])
          format.html { redirect_to @attr_val, notice: 'Attr val was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @attr_val.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /attr_vals/1
    # DELETE /attr_vals/1.json
    def destroy
      @attr_val = AttrVal.find(params[:id])
      @attr_val.destroy
  
      respond_to do |format|
        format.html { redirect_to databaseformalizer_attr_vals_url }
        format.json { head :no_content }
      end
    end
  end
end