# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

# Create Random User
20.times do
  User.create!(
  email: Faker::Internet.email,
  password: "password",
  role: [:standard, :premium, :admin].sample
)
end


50.times do
# #1
  Wiki.create!(
# #2
    title:  Faker::GameOfThrones.quote,
    body:   Faker::Lorem.paragraph(2),
    private: [:true, :false].sample,
    user_id: User.all.sample.id,
  )
end
Wikis = Wiki.all
Users = User.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{Users.count} users created"
