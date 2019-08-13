FactoryBot.define do
  factory :quiz do
    sequence(:id) { |n| n }
    title { "Software Languages" }
    description { "Stay sharp" }
    user

    factory :quiz_with_decks do
      after(:create) do |quiz| 
        # create(:deck, quiz: quiz)
        # create(:deck, quiz: quiz)
        # create(:deck, quiz: quiz)
        create_list(:deck, 3, quizzes: [quiz])
      end
    end
  end
end