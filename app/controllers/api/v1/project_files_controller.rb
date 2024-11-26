class Api::V1::ProjectFilesController < ApplicationController
  before_action :authenticate_request

  def index
    project_files = ProjectFile.all
    render json: project_files, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Project not found" }, status: :not_found
  end

  def show
    file = ProjectFile.find(params[:id])
    render json: file, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "File not found" }, status: :not_found
  end

  def create
    file = ProjectFile.new(file_params)
    if file.save
      file.project.deploy!
      render json: file, status: :created
    else
      render json: { errors: file.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    file = ProjectFile.find(params[:id])
    if file.update(file_params)
      file.project.deploy!
      render json: file, status: :ok
    else
      render json: { errors: file.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'File not found' }, status: :not_found
  end

  def destroy
    file = ProjectFile.find(params[:id])
    file.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'File not found' }, status: :not_found
  end

  private

  def file_params
    params.require(:project_file).permit(:name, :content, :file_path, :project_id)
  end
end
