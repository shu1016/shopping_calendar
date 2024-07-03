FactoryBot.define do
  factory :event do
    title     {Faker::Lorem.sentence}
    content   {Faker::Lorem.sentence}
    start_time{Faker::Time.between(from: DateTime.now, to: DateTime.now + 100)}
    end_time  {Faker::Time.between(from: start_time, to: start_time + 3.days)}
    association :user
  end
end
