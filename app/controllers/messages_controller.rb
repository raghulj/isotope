class MessagesController < ApplicationController
    before_filter :require_user
    before_filter :get_project

  def index
    @messages = @project.messages.find(:all)
  end

  def show
    @message = @project.messages.find(params[:id])
  end

  def new
    @message = @project.messages.new
  end

  def edit
    @message = @project.messages.find(params[:id])
  end

  def create
    @message = @project.messages.new(params[:message])
    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to  "/projects/#{@project.id}/messages" }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @message = @project.messages.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to "/projects/#{@project.id}/messages" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to "/projects/#{@project.id}/messages" }
      format.xml  { head :ok }
    end
  end

  def get_project
      @project = Project.find(params[:project_id])
  end
end
