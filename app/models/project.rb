class Project < ApplicationRecord
  belongs_to :user
  has_many :project_files

  def deploy!
    # deploys the project
    raise(ActiveRecord::RecordInvalid) unless deployable
  end

  def ping
    # pings project endpoint
  end

  def deployable?
    deployable
  end
end
