FactoryBot.define do
  factory :goal do
    theme              {Faker::Lorem.sentence}
    purpose            {Faker::Lorem.sentence}
    target_total_time  {Faker::Number.within(range: 1..999)}
    association :user
  end
end
