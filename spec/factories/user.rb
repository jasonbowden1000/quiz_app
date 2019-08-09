FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:email) { |n| "autobots@teletran#{n}.com" }
    first_name { "Optimus" }
    last_name { "Prime" }
    password { "orionpax123" }
    confirmed_at { Time.now } 

    factory :user_with_quizzes do
      transient do
        quizzes_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:quiz, evaluator.quizzes_count, user: user)
      end
    end

    factory :user_with_decks do
      transient do
        decks_count { 3 }
      end

      after(:create) do |user, evaluator|
        create_list(:deck, evaluator.decks_count, user: user)
      end
    end
  end
end