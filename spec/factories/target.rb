FactoryBot.define do
  factory :target do
    title      { Faker::Name.unique.name }
    latitude { Faker::Number.between(from: -90.0, to: 90.0).round(6) }
    longitude { Faker::Address.longitude }
    radius { Faker::Number.between(from: 0.0, to: 2000.0).round(2) }
  end
end
