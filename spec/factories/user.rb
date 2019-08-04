FactoryBot.define do
  factory :user do
    email { "autobots@teletran1.com" }
    first_name { "Optimus" }
    last_name { "Prime" }
  end

  factory :second_user do
    email { "autobots@primus.com" }
    first_name { "Alpha" }
    last_name { "Trion" }
  end
end