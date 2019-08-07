class Question < ApplicationRecord
  MULTIPLE_CHOICE = 0
  belongs_to :deck
  has_many :answers
  
  validates :text, presence: true
  validates :description, presence: true
  validates :question_type, presence: true

  validate :answer_consistency

  accepts_nested_attributes_for :answers

  def answer_consistency
    if question_type == MULTIPLE_CHOICE
      if answers.select { |answer| answer.truth_value == true }.count > 1
        errors[:base] << "Multiple choice questions should only have one correct answer." 
      end
    end
  end

end
