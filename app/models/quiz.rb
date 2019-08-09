class Quiz < ApplicationRecord
  has_and_belongs_to_many :decks
  belongs_to :user
end
