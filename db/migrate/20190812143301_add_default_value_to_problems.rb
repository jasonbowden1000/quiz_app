class AddDefaultValueToProblems < ActiveRecord::Migration[5.2]
  def change
    change_column :problems, :answered, :boolean, default: false
  end
end
