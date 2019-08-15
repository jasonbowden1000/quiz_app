class Problem < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  has_many :choices, through: :question
  before_update :prepare_update

  attr_accessor :submitted_answer

  validate :validate_submitted_answer, on: :update

  scope :correct, -> { where(correct: true) }
  scope :finished, -> { where(answered: true) }

  def self.find_first
    where(problem_order: 1).first
  end

  def correct_choice
    if question_type == Rails.configuration.x.question_type.MULTIPLE_CHOICE
      correct_choice = question.choices.find { |c| c.truth_value }
    end

    correct_choice
  end

  def current?
    succedent && succedent.id == id
  end

  def succedent
    Problem.order(:problem_order).find_by(answered: false, attempt_id: attempt.id)
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