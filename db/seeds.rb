# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create(username: 'bob1', email: 'bob1@gmail.com', password: '12345678')
user2 = User.create(username: 'stan92', email: 'stan@gmail.com', password: 'new_password')

project1 = Project.create(name: 'Project 1', description: 'The first project', user_id: user.id)
project2 = Project.create(name: 'Project 2', description: 'The second project', user_id: user.id)
project3 = Project.create(name: 'Project 3', description: 'The third project', user_id: user.id)

project_files1 = ProjectFile.create(name: 'Project File 1 for Project 1', content: 'The file 1', project_id: project1.id)
project_files2 = ProjectFile.create(name: 'Project File 2 for Project 1', content: 'The file 2', project_id: project1.id)
project_files3 = ProjectFile.create(name: 'Project File 3 for Project 1', content: 'The file 3', project_id: project1.id)

project_files4 = ProjectFile.create(name: 'Project File 1 for Project 2', content: 'The file 4', project_id: project2.id)
project_files5 = ProjectFile.create(name: 'Project File 2 for Project 2', content: 'The file 5', project_id: project2.id)
