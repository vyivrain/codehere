class AddDeployableToApps < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :deployable, :boolean, default: true
  end
end
