class Problem < ApplicationRecord
  belongs_to :attempt
  belongs_to :question

  def correct_choice
    if question_type == Rails.configuration.x.question_type.MULTIPLE_CHOICE
      correct_choice = question.choices.find { |c| c.truth_value }
    end

    return correct_choice
  end

  def next
    attempt.problems.order(:order).find_by(answered: false)
  end

  private 

  def question_type
    question.question_type
  end
end