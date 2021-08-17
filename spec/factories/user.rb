FactoryBot.define do
  factory :user do
    email      { Faker::Internet.unique.email }
    password { 'password' }
    confirmed_at { Time.zone.today }
    gender { 'female' }
  end
end
