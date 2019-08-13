FactoryBot.define do
  factory :quiz do
    sequence(:id) { |n| n }
    title { "Software Languages" }
    description { "Stay sharp" }
    user

    factory :quiz_with_decks do
      transient do
        decks_count { 3 } 
      end

      after(:create) do |quiz, evaluator| 
        create_list(:deck_with_questions, evaluator.decks_count, quizzes: [quiz])
      end
    end
  end
end