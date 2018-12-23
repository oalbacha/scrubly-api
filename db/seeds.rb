# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# seed 50 records
50.times do
  patient = Patient.create(first_name: Faker::FunnyName.name, last_name: Faker::FunnyName.name, phone: Faker::FunnyName.name)
  patient.appointments.create(title: Faker::FamousLastWords.last_words)
end