class Quiz < ApplicationRecord
  has_and_belongs_to_many :decks
  has_many :questions, through: :decks
  belongs_to :user
end
