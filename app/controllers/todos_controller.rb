class TodosController < ApplicationController
    before_filter :require_user
    before_filter :get_project

  def index
    @todos = @project.todos.all
  end

  def show
    @todo = @project.todos.find(params[:id])
  end

  def new
    @todo = @project.todos.new
  end

  def edit
    @todo = @project.todos.find(params[:id])
  end

  def create
    @todo = @project.todos.new(params[:todo])

    respond_to do |format|
      if @todo.save
        flash[:notice] = 'Todo was successfully created.'
        format.html { redirect_to "/projects/#{@project.id}/todos" }
        format.xml  { render :xml => @todo, :status => :created, :location => @todo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @todo = @project.todos.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        flash[:notice] = 'Todo was successfully updated.'
        format.html { redirect_to "/projects/#{@project.id}/todos" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @todo.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo = @project.todos.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to "/projects/#{@project.id}/todos" }
      format.xml  { head :ok }
    end
  end

  def get_project
      @project = Project.find(params[:project_id])
  end
end
