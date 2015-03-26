class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def new
    @builder = ProjectBuilder.new(current_user)
  end

  def create
    @builder = ProjectBuilder.new(current_user, project_params)

    if @builder.build
      redirect_to project_path(@builder.project)
    else
      render "new"
    end
  end

  def show
    @project = Project.find_by_id(params[:id])
  end

private

  def project_params
    params.require(:project_builder).permit(:title, :description)
  end
end