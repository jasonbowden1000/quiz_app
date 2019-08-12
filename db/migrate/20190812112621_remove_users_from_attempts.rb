class RemoveUsersFromAttempts < ActiveRecord::Migration[5.2]
  def change
    remove_reference :attempts, :users, foreign_key: true
  end
end
