class Quiz < ApplicationRecord
  has_and_belongs_to_many :decks, -> {where(active: true) }
  has_many :questions, through: :decks
  belongs_to :user

  scope :active, -> { where(active: true) }

  def soft_delete
    update(active: false)
  end
end
