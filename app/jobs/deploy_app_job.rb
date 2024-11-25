class DeployAppJob < ApplicationJob
  queue_as :default

  def perform(app)
    app.deploy
  end
end
