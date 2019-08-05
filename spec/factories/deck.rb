FactoryBot.define do
  factory :deck do
    id { 1 }
    title { "Networking" }
    description { "Don't forget the broader concepts." }
    user
  end
end