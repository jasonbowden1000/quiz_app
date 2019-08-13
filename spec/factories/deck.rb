FactoryBot.define do
  factory :deck do
    sequence(:title) { |n| "Deck #{n}" }
    description { "Don't forget the broader concepts." }
    user

=begin
    factory :deck_with_questions do
      transient do
        questions_count { 3 }
      end

      after(:create) do |deck, evaluator|
        create_list(:questions, evaluator.questions_count, deck: deck)
      end
    end
=end
  end
end