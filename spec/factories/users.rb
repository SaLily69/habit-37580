FactoryBot.define do
  factory :user do
    nickname  {Faker::Name.initials(number: 10)}
    email     {Faker::Internet.free_email}
  end
end