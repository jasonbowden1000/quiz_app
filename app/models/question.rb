class Question < ApplicationRecord
  belongs_to :deck
  has_many :answers
  
  validates :text, presence: true
  validates :description, presence: true
  validates :type, presence: true

  accepts_nested_attributes_for :answer
end
