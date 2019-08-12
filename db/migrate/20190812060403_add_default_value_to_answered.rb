class AddDefaultValueToAnswered < ActiveRecord::Migration[5.2]
  def change
    change_column :answers, :answered, :boolean, default: false
  end
end
