class RemoveQuizzesFromAttempts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :attempts, :quizzes, foreign_key: true
  end
end
