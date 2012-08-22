class <%= plural_name.camelize %>Controller < ApplicationController
  # GET /<%= plural_name %>
  # GET /<%= plural_name %>.xml
  
  def index
    @<%= plural_name %> = <%= class_name %>.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= plural_name %> }
    end
  end

  # GET /<%= plural_name %>/1
  # GET /<%= plural_name %>/1.xml
  def show
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= singular_name %> }
    end
  end

  # GET /<%= plural_name %>/new
  # GET /<%= plural_name %>/new.xml
  def new
    @<%= singular_name %> = <%= class_name %>.new
    
    @attrs = Array.new
    attrsList = Databaseformalizer::EntityDef.find("<%= class_name %>").attrDefs
    attrsList.each do |attr|
      @attrs << Databaseformalizer::AttrDef.find(attr)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= singular_name %> }
    end
  end

  # GET /<%= plural_name %>/1/edit
  def edit
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
  end
  
  # POST /<%= plural_name %>
  # POST /<%= plural_name %>.xml
  def create
    @<%= singular_name %> = <%= class_name %>.new(
      :entity_def_id => "<%= class_name %>",
      :label=>params[:<%= singular_name %>][:label], 
      :description => params[:<%= singular_name %>][:description]
    )
    Databaseformalizer::EntityDef.find("<%= class_name %>").attrDefs.each do |attr|
      if params[:attr_vals][attr.label] != nil
        @planned_event.update_attribute(attr.label, params[:attr_vals][attr.label])
      end
    end
    respond_to do |format|
      if @<%= singular_name %>.save
        format.html { redirect_to(@<%= singular_name %>, :notice => '<%= class_name %> was successfully created.') }
        format.xml  { render :xml => @<%= singular_name %>, :status => :created, :location => @<%= singular_name %> }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= singular_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /<%= plural_name %>/1
  # PUT /<%= plural_name %>/1.xml
  def update
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    
    respond_to do |format|
      if @<%= singular_name %>.update_attributes(params[:<%= singular_name %>])
        format.html { redirect_to(@<%= singular_name %>, :notice => response) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @<%= singular_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= plural_name %>/1
  # DELETE /<%= plural_name %>/1.xml
  def destroy
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    @<%= singular_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= plural_name %>_url) }
      format.xml  { head :ok }
    end
  end
end
