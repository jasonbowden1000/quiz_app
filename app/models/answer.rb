class Answer < ApplicationRecord
  belongs_to :question
  validates :text, presence: true
  validates :truth_value, inclusion: { in: [true, false] }
end
