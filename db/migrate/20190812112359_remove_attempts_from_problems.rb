class RemoveAttemptsFromProblems < ActiveRecord::Migration[5.2]
  def change
    remove_reference :problems, :attempts, foreign_key: true
  end
end
