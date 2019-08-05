class AddAnswersToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference(:answers, :question)
  end
end
