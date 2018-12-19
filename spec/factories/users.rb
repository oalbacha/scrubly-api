FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {'foo@bar.com'}
    password {'password'}
    password_confirmation {'password'}
  end
end