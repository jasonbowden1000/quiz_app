FactoryBot.define do
  factory :quiz do
    sequence(:id) { |n| n }
    title { "Software Languages" }
    description { "Stay sharp" }
    user
  end
end