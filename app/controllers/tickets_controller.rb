class TicketsController < ApplicationController
  before_filter :require_user
  before_filter :get_project

  def index
    @tickets = @project.tickets.all
  end

  def show
    @ticket = @project.tickets.find(params[:id])
  end

  def new
    @ticket = @project.tickets.new
  end

  def edit
    @ticket = @project.tickets.find(params[:id])
  end

  def create
    @ticket = @project.tickets.new(params[:ticket])
    @ticket.assigne = current_user.id
    respond_to do |format|
      if @ticket.save
        flash[:notice] = 'Ticket was successfully created.'
        format.html { redirect_to "/projects/#{@project.id}/tickets" }
        format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @ticket = @project.tickets.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        flash[:notice] = 'Ticket was successfully updated.'
        format.html { redirect_to "/projects/#{@project.id}/tickets" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket = @project.tickets.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to "/projects/#{@project.id}/tickets" }
      format.xml  { head :ok }
    end
  end

  def get_project
      @project = Project.find(params[:project_id])
  end
end
