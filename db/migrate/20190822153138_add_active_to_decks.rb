class AddActiveToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :active, :boolean, default: true
  end
end
