class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.date :date, index: true
      t.integer :plan_time
      t.integer :actual_time
      t.text :memo
      t.integer :importance, default: 50
      t.integer :urgency, default: 50
      t.integer :progress, default: 0, index: true
      t.integer :frequency, default: 0, index: true

      t.timestamps
    end
  end
end
