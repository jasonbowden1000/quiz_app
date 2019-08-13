class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many :problems

  accepts_nested_attributes_for :problems
end