FactoryBot.define do
  factory :question do
    question_type { 0 }
    sequence(:text) { |n| "Question #{n}" }
    description { "A Question" }
    deck
  end
end