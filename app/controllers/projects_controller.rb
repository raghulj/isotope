class ProjectsController < ApplicationController
  # GET /projects
  before_filter :require_user 
  before_filter :has_rights_to_admin, :only => [:new, :create,:update, :settings]
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    @messages = @project.messages.find(:all,:order => 'updated_at desc',:limit => 3 )
    @tickets = @project.tickets.find(:all,:order => 'updated_at desc', :limit => 6 )
    @todos = @project.todos.find(:all,:order => 'updated_at desc', :limit => 6 )
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def settings
      @project = Project.find(params[:id])
      @users = User.all.collect {|u| u.id} -  @project.memberships.collect {|h| h.user_id }
      @people = @project.memberships.select { |u| u.user_id }
  end

  def add_user
      if Project.find(params[:project_id]).memberships.create!(:user_id => params[:user_id])
                     redirect_to "/projects/settings/#{params[:project_id]}" 
      end
  end
  
  def delete_user
      m = Membership.find(params[:id])
      proj_id = m.project_id
      if m.delete
          redirect_to "/projects/settings/#{proj_id}"
      end
  end
   
  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
