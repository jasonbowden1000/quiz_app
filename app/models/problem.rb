class Problem < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  before_update :prepare_update

  attr_accessor :submitted_answer

  validate :validate_submitted_answer, on: :update

  def correct_choice
    if question_type == Rails.configuration.x.question_type.MULTIPLE_CHOICE
      correct_choice = question.choices.find { |c| c.truth_value }
    end

    correct_choice
  end

  def next
    attempt.problems.order(:problem_order).find_by(answered: false)
  end

  def to_param
    problem_order.to_s
  end

  private 

  def question_type
    question.question_type
  end

  def prepare_update
    self.correct = correct_choice.id == submitted_answer.to_i
    self.answered = true
  end

  def validate_submitted_answer
    errors.add(:base, "Please make a selection") if submitted_answer.empty?
  end
end