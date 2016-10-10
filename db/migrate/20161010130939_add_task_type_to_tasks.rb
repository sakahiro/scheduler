class AddTaskTypeToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :purpose, :integer, null: false, default: 0
  end
end
