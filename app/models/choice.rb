class Choice < ApplicationRecord
  belongs_to :question
  validates :text, presence: true
  validates :truth_value, inclusion: { in: [true, false] }

  scope :correct, -> { where(truth_value: true) }
end
