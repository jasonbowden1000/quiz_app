class AddUsersToDecks < ActiveRecord::Migration[5.2]
  def change
    if foreign_key_exists?(:users, :decks)
      remove_foreign_key :users, :decks
    end

    if foreign_key_exists?(:decks, :users)
      remove_foreign_key :decks, :users
    end
  end
end