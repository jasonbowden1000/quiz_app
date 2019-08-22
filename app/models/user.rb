class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :decks
  has_many :quizzes
  has_many :attempts

  def active_decks
    decks.active
  end

  def active_quizzes
    quizzes.active
  end
end
