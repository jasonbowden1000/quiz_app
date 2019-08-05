class Deck < ApplicationRecord
  belongs_to :user
  has_many :questions
  validates :user, presence: true
  validates :title, presence: true
  validates :description, presence: true
end
