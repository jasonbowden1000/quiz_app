class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.boolean :answered
      t.integer :order
      t.references :questions, foreign_key: true
      t.references :attempts, foreign_key: true
      t.boolean :correct
    end
  end
end
