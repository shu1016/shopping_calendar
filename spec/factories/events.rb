FactoryBot.define do
  factory :event do
    association :user
    title     {Faker::Lorem.sentence}
    content   {Faker::Lorem.sentence}
    start_time{Faker::Time.between(from: DateTime.now, to: DateTime.now + 0.5)}
    end_time  {Faker::Time.between(from: start_time, to: start_time + 3.days)}
  end
end
