FactoryBot.define do
  factory :quiz do
    sequence(:id) { |n| n }
    title { "Software Languages" }
    description { "Stay sharp" }
    user

    transient do
      decks_count { 3 } 
    end

    factory :quiz_with_decks do
      after(:create) do |quiz, evaluator| 
        create_list(:deck_with_questions, evaluator.decks_count, quizzes: [quiz])
      end
    end

    factory :quiz_with_empty_decks do
      after(:create) do |quiz, evaluator|
        create_list(:deck, evaluator.decks_count, quizzes: [quiz])
      end
    end
  end
end