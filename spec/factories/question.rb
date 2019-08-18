FactoryBot.define do
  factory :question do
    question_type { 0 }
    sequence(:text) { |n| "Question #{n}" }
    description { "A Question" }
    deck
    
    transient do
      choices_count { 3 }
    end

    factory :multiple_choice_question do
      before(:create) do |question, evaluator|
        question.choices << build(:choice, truth_value: true, question: question)
        question.choices << build_list(:choice, evaluator.choices_count, question: question)
      end
    end

    factory :multiple_answer_question do
      question_type { 1 }
      before(:create) do |question, evaluator|
        question.choices << build(:choice, truth_value: true, question: question)
        question.choices << build(:choice, truth_value: false, question: question)
        question.choices << build(:choice, truth_value: true, question: question)
        question.choices << build(:choice, truth_value: false, question: question)
      end
    end
  end
end