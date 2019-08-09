class CreateJoinTableQuizzesDecks < ActiveRecord::Migration[5.2]
  def change
    create_join_table :quizzes, :decks do |t|
      t.index [:quiz_id, :deck_id]
      t.index [:deck_id, :quiz_id]
    end
  end
end
