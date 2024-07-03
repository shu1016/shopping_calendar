FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {"1a"+Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    region_id             {Faker::Number.between(from: 2, to: 48)}
    city                  {"手すtoシ"}
  end
end