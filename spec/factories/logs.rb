FactoryBot.define do
  factory :log do
    study_day      {Faker::Date.between(from: 7.days.ago, to: Date.today)}
    study_hour     {Faker::Number.within(range: 0..23)}
    study_minute   {Faker::Number.within(range: 0..59)}
    task           {Faker::Lorem.sentence}
    feed_back      {Faker::Number.within(range: 1..5)}
    time_remind    {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)}
    association :goal
  end
end
