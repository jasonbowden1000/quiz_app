class DropAttemptsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :attempts_tables
  end
end
