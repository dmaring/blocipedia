# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'

# Create Random User
randomUser = User.create!(
  email: "randomuser@example.com",
  password: "password"
)


50.times do
# #1
  Wiki.create!(
# #2
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph,
    private: false,
    user_id: randomUser.id,
  )
end
Wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
