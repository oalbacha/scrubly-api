# spec/factories/appointments.rb
FactoryBot.define do
  factory :appointment do
    patient
    title { Faker::Lorem.word }
  end
end