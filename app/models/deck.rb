class Deck < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_and_belongs_to_many :quizzes
  validates :user, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
