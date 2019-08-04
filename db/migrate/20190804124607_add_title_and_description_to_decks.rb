class AddTitleAndDescriptionToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :title, :string
    add_column :decks, :description, :text
  end
end
