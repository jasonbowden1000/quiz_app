class AddActiveToQuizzes < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :active, :boolean, default: true
  end
end
