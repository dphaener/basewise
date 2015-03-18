class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to project_path(@project)
    else
      render "new"
    end
  end

  def show
    @project = Project.find_by_id(params[:id])
  end

private

  def project_params
    params.require(:project).permit(:title, :description)
  end
end