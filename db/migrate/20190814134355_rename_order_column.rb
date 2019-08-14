class RenameOrderColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :problems, :order, :problem_order
  end
end
