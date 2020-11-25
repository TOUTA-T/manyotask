class AddStep3ToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime, default: -> { 'NOW()' }, null: false
    add_column :tasks, :status, :string, default: "未完了", null: false
  end
end
