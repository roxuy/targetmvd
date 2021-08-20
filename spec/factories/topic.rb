FactoryBot.define do
  factory :topic do
    label { Faker::Name.unique.name }
    icon { Faker::Name.unique }
  end
end
