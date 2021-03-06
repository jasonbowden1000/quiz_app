class Question < ApplicationRecord
  belongs_to :deck
  has_many :choices
  has_many :problems
  accepts_nested_attributes_for :choices
  
  validates :text, presence: true
  validates :description, presence: true
  validates :question_type, presence: true

  include ActiveModel::Validations
  validates_with ChoiceValidator

  def correct_choices
    choices.correct
  end
end
