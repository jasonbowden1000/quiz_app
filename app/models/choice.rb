class Choice < ApplicationRecord
  belongs_to :question
  validates :text, presence: true, unless: :is_true_false?
  validates :truth_value, inclusion: { in: [true, false] }

  scope :correct, -> { where(truth_value: true) }

  private

  def is_true_false?
    question.question_type == Rails.configuration.x.question_type.TRUE_FALSE
  end
end
