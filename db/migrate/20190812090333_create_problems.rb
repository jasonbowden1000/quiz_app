class CreateProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :problems do |t|
      t.boolean :answered
      t.integer :order
      t.boolean :correct
      t.references :questions, foreign_key: true
      t.references :attempts, foreign_key: true
    end
  end
end
