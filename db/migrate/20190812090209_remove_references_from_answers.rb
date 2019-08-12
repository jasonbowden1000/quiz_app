class RemoveReferencesFromAnswers < ActiveRecord::Migration[5.2]
  def change
    remove_reference :answers, :attempts, foreign_key: true
    remove_reference :answers, :questions, foreign_key: true
  end
end
