class Question < ApplicationRecord
  belongs_to :deck
  has_many :choices
  accepts_nested_attributes_for :choices
  
  validates :text, presence: true
  validates :description, presence: true
  validates :question_type, presence: true

  include ActiveModel::Validations
  validates_with ChoiceValidator
end
