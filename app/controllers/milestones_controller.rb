class MilestonesController < ApplicationController
  
  before_filter :require_user
  before_filter :get_project
  def index
    @milestones = @project.milestones.find(:all,:order => 'created_at desc')
  end

  def show
    @milestone = @project.milestones.find(params[:id])
  end

  def new
    @milestone = @project.milestones.new
  end

  # GET /milestones/1/edit
  def edit
    @milestone = @project.milestones.find(params[:id])
  end

  def create
    @milestone = @project.milestones.new(params[:milestone])

    respond_to do |format|
      if @milestone.save
        flash[:notice] = 'Milestone was successfully created.'
        format.html { redirect_to "/projects/#{@project.id}/milestones" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @milestone.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @milestone = @project.milestone.find(params[:id])

    respond_to do |format|
      if @milestone.update_attributes(params[:milestone])
        flash[:notice] = 'Milestone was successfully updated.'
        format.html { redirect_to(@milestone) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @milestone.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @milestone = @project.milestone.find(params[:id])
    @milestone.destroy

    respond_to do |format|
      format.html { redirect_to(milestones_url) }
      format.xml  { head :ok }
    end
  end

  def get_project
      @project = Project.find(params[:project_id])
  end
end
