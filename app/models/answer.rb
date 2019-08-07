class Answer < ApplicationRecord
  belongs_to :question

  validates :text, presence: true
  validates :truth_value, inclusion: { in: [true, false] }

  after_validation :give_errors_some_love

  private
  
  def give_errors_some_love
    Rails.logger.info 'giving errors some love'
    Rails.logger.info errors.full_messages
    if errors.added?(:text, :blank)
      Rails.logger.info('text blank has been added')
      errors.add(:base, :answers, message: "Answers cannot be blank")
    else
      Rails.logger.info "wut"
    end
  end
end
