FactoryBot.define do
  factory :user do
    email { "autobots@teletran1.com" }
    first_name { "Optimus" }
    last_name { "Prime" }
    password { "orionpax123" }
    confirmed_at { Time.now } 
  end
end