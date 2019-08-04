FactoryBot.define do
  factory :deck do
    title { "Networking" }
    description { "Don't forget the broader concepts." }
    user
  end
end