FactoryBot.define do
  factory :favorite do
    association :user
    association :event
  end
end
