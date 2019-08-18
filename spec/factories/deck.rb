FactoryBot.define do
  factory :deck do
    sequence(:title) { |n| "Deck #{n}" }
    description { "Don't forget the broader concepts." }
    user

    transient do
      questions_count { 4 }
    end

    factory :deck_with_questions do
      after(:create) do |deck, evaluator|
        create_list(:multiple_choice_question, evaluator.questions_count, deck: deck)
      end
    end

    factory :multiple_answer_deck do
      after(:create) do |deck, evaluator|
        create_list(:multiple_answer_question, evaluator.questions_count, deck: deck, question_type: 1)
      end
    end
  end
end