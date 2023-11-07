# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
number = 1
10.times do
  User.create( 
    email: "test#{number}@yopmail.com",
    password: "azerty1",
    password_confirmation: "azerty1",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence(word_count: 5))
    number += 1

end



10.times do
  Event.create(
    start_date: Faker::Date.forward(days: 30),
    title: Faker::Lorem.word,
    duration: 500,
    description: Faker::Lorem.sentence,
    price: rand(10..200),
    location: "montpellier",
    admin_id: User.all.sample.id  )
end