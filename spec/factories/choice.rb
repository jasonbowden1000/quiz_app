FactoryBot.define do
  factory :choice do
    sequence(:text) { |n| "Choice #{n}" }
    truth_value { false }
    question
  end
end