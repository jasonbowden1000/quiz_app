class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.boolean :truth_value, default: true
      t.text :text

      t.timestamps
    end
  end
end
