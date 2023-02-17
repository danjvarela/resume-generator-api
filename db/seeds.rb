# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user_email = "sample@email.com"
user = User.find_by(email: user_email)

if user.blank?
  user = User.create email: user_email, password: "password"
  user.confirm
end

3.times do
  FactoryBot.create :job, user: user
  FactoryBot.create :user_skill, user: user
  FactoryBot.create :resume, user: user
  FactoryBot.create :education, user: user
end

