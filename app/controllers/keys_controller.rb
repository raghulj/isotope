require 'repoinit'
class KeysController < ApplicationController
  include Repoinit
    # GET /keys
  # GET /keys.xml
  def index
    @keys = Key.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @keys }
    end
  end

  # GET /keys/1
  # GET /keys/1.xml
  def show
    @key = Key.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @key }
    end
  end

  # GET /keys/new
  # GET /keys/new.xml
  def new
    @key = Key.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @key }
    end
  end

  # GET /keys/1/edit
  def edit
    @key = Key.find(params[:id])
  end

  # POST /keys
  # POST /keys.xml
  def create
    @key = Key.new(params[:key])
    @key.git_name = @key.value.split("== ")[1].strip.to_s
    @key.user_id = current_user.id 
    respond_to do |format|
      if @key.save
        @key.add_key_to_git
        flash[:notice] = 'Key was successfully created.'
        format.html { redirect_to(@key) }
        format.xml  { render :xml => @key, :status => :created, :location => @key }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /keys/1
  # PUT /keys/1.xml
  def update
    @key = Key.find(params[:id])

    respond_to do |format|
      if @key.update_attributes(params[:key])
        @key.add_key_to_git
        flash[:notice] = 'Key was successfully updated.'
        format.html { redirect_to(@key) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @key.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /keys/1
  # DELETE /keys/1.xml
  def destroy
    @key = Key.find(params[:id])
    @key.delete_key_from_git
    @key.destroy

    respond_to do |format|
      format.html { redirect_to(keys_url) }
      format.xml  { head :ok }
    end
  end
end
