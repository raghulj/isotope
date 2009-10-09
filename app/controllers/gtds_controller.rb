class GtdsController < ApplicationController
  # GET /gtds
  # GET /gtds.xml
  def index
    @gtds = Gtd.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @gtds }
    end
  end

  # GET /gtds/1
  # GET /gtds/1.xml
  def show
    @gtd = Gtd.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @gtd }
    end
  end

  # GET /gtds/new
  # GET /gtds/new.xml
  def new
    @gtd = Gtd.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @gtd }
    end
  end

  # GET /gtds/1/edit
  def edit
    @gtd = Gtd.find(params[:id])
  end

  # POST /gtds
  # POST /gtds.xml
  def create
    @gtd = Gtd.new(params[:gtd])

    respond_to do |format|
      if @gtd.save
        flash[:notice] = 'Gtd was successfully created.'
        format.html { redirect_to(@gtd) }
        format.xml  { render :xml => @gtd, :status => :created, :location => @gtd }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @gtd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /gtds/1
  # PUT /gtds/1.xml
  def update
    @gtd = Gtd.find(params[:id])

    respond_to do |format|
      if @gtd.update_attributes(params[:gtd])
        flash[:notice] = 'Gtd was successfully updated.'
        format.html { redirect_to(@gtd) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @gtd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /gtds/1
  # DELETE /gtds/1.xml
  def destroy
    @gtd = Gtd.find(params[:id])
    @gtd.destroy

    respond_to do |format|
      format.html { redirect_to(gtds_url) }
      format.xml  { head :ok }
    end
  end
end
