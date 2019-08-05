class AddQuestionsToDecks < ActiveRecord::Migration[5.2]
  def change
    add_reference(:questions, :deck)
  end
end
