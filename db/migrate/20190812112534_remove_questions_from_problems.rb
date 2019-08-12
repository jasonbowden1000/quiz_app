class RemoveQuestionsFromProblems < ActiveRecord::Migration[5.2]
  def change
    remove_reference :problems, :questions, foreign_key: true
  end
end
