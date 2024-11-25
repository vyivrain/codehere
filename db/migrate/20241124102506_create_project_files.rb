class CreateProjectFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :project_files do |t|
      t.string :name
      t.text :content
      t.string :file_path
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
