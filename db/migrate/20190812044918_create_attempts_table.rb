class CreateAttemptsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :attempts_tables do |t|
      t.integer :status
      t.references :users, foreign_key: true
      t.references :quizzes, foreign_key: true
    end
  end
end
