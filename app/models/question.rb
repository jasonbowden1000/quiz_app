class Question < ApplicationRecord
  MULTIPLE_CHOICE = 0
  belongs_to :deck
  has_many :answers
  accepts_nested_attributes_for :answers
  
  validates :text, presence: true
  validates :description, presence: true
  validates :question_type, presence: true

  validates_associated :answers

  validate :answer_consistency

  private

  def answer_consistency
    if question_type == MULTIPLE_CHOICE
      true_answers, false_answers = answers.partition { |answer| answer.truth_value == true }

      if answers.size < 2
        errors[:base] << "Multiple choice questions should have at least two choices"
      else
        if true_answers.size > 1
          errors[:base] << "Multiple choice questions should only have one correct answer." 
        elsif true_answers.size < 1
          errors[:base] << "All Multiple choice options cannot be false"
        end
      end
    end
  end
end
