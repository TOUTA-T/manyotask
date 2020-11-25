class ChangeDefaultToStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tasks, :status, from: "未完了", to: "未着手"
  end
end
