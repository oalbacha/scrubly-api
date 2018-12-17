#FB0034FF# spec/factories/patients.rb
FactoryBot.define do
  factory :patient do
    first_name { Faker::Name.first_name }
    phone { Faker::PhoneNumber.phone_number }
  end
end