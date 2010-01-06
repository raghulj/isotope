require 'repoinit'
class RepositoriesController < ApplicationController
    include Repoinit
    before_filter :get_project
  
    # GET /repositories
  # GET /repositories.xml
  def index
    @repositories =  @project.repositories.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @repositories }
    end
  end

  # GET /repositories/1
  # GET /repositories/1.xml
  def show
    @repository = Repository.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @repository }
    end
  end

  # GET /repositories/new
  # GET /repositories/new.xml
  def new
    @repository = Repository.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @repository }
    end
  end

  # GET /repositories/1/edit
  def edit
    @repository = Repository.find(params[:id])
  end

  # POST /repositories
  # POST /repositories.xml
  def create
    @repository = @project.repositories.new(params[:repository])
    @repository.path = '/home/git/repositories'
    @repository.repo_name = @repository.name.downcase.gsub(" ","_")
    respond_to do |format|
      if @repository.save
        flash[:notice] = 'Repository was successfully created.'
        format.html { redirect_to([@project,@repository]) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /repositories/1
  # PUT /repositories/1.xml
  def update
    @repository = Repository.find(params[:id])

    respond_to do |format|
      if @repository.update_attributes(params[:repository])
        flash[:notice] = 'Repository was successfully updated.'
        format.html { redirect_to project_repositories_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @repository.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1
  # DELETE /repositories/1.xml
  def destroy
    @repository = @project.repositories.find(params[:id])
    @repository.destroy

    respond_to do |format|
      format.html { redirect_to project_repositories_path }
      format.xml  { head :ok }
    end
  end

  def get_project
      @project = Project.find(params[:project_id])
  end
end
