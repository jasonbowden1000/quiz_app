class AddQuestionToProblems < ActiveRecord::Migration[5.2]
  def change
    add_reference :problems, :question, foreign_key: true
  end
end
