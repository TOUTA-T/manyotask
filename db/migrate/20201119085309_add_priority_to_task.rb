class AddPriorityToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :string, default: "中", null: false
  end
end
