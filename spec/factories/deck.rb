FactoryBot.define do
  factory :deck do
    sequence(:title) { |n| "Deck #{n}" }
    description { "Don't forget the broader concepts." }
    user

    transient do
      questions_count { 3 }
    end

    factory :deck_with_questions do
      after(:create) do |deck, evaluator|
        create_list(:question, evaluator.questions_count, deck: deck)
      end
    end
  end
end