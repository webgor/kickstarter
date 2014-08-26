class ProjectsController < ApplicationController
  before_action :require_current_user, except: :new

  def new
    @project = Project.new
    render :new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to edit_project_url(@project)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    render :edit
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)

    else

    end
  end

  def show
    @project = Project.find(params[:id])
    render :show
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to root_url
  end

  def learn
    render :learn
  end

  def start
    render :start
  end

  private
  def project_params
    params.permit(:project).require(:title, :category_id)
  end
end







