class ChirpsController < ApplicationController
  # GET /chirps
  # GET /chirps.xml
  def index
    @chirps = Chirp.all
    @chirp = Chirp.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chirps }
    end
  end

  # GET /chirps/1
  # GET /chirps/1.xml
  def show
    @chirp = Chirp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chirp }
    end
  end

  # GET /chirps/new
  # GET /chirps/new.xml
  def new
    @chirp = Chirp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @chirp }
    end
  end

  # GET /chirps/1/edit
  def edit
    @chirp = Chirp.find(params[:id])
  end

  # POST /chirps
  # POST /chirps.xml
  def create
    @chirp = Chirp.new(params[:chirp])

    @chirp.user_id = current_user.id
      if @chirp.save
        flash[:notice] = 'Chirp was successfully created.'
        redirect_to :action => "index"
      end
  end

  # PUT /chirps/1
  # PUT /chirps/1.xml
  def update
    @chirp = Chirp.find(params[:id])

    respond_to do |format|
      if @chirp.update_attributes(params[:chirp])
        flash[:notice] = 'Chirp was successfully updated.'
        format.html { redirect_to(@chirp) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chirp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /chirps/1
  # DELETE /chirps/1.xml
  def destroy
    @chirp = Chirp.find(params[:id])
    @chirp.destroy

    respond_to do |format|
      format.html { redirect_to(chirps_url) }
      format.xml  { head :ok }
    end
  end
end
