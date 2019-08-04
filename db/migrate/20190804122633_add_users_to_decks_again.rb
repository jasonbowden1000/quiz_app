class AddUsersToDecksAgain < ActiveRecord::Migration[5.2]
  def change
    add_reference(:decks, :user)
  end
end
