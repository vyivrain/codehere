class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_request

  def index
    user = User.find(params[:user_id])
    projects = Project.all

    render json: { projects: projects, user: user }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User or project is not found" }, status: :not_found
  end

  def show
    project = Project.find(params[:id])
    render json: project.attributes.merge(project_files: project.project_files.map { |pf| pf.attributes.slice('name', 'content') }).to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Project not found" }, status: :not_found
  end

  def create
    project = Project.new(project_params)
    if project.save
      DeployAppJob.perform_later(project) if project.deployable?
      render json: project, status: :created
    else
      render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    project = Project.find(params[:id])
    if project.update(project_params)
      render json: project, status: :ok
    else
      render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Project not found' }, status: :not_found
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Project not found' }, status: :not_found
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :deployable, :user_id, project_file_attributes: %i[name content file_path])
  end
end
