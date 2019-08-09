FactoryBot.define do
  factory :deck do
    sequence(:title) { |n| "Deck #{n}" }
    description { "Don't forget the broader concepts." }
    user
  end
end