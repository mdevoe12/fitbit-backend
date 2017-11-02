class CreateSleeps < ActiveRecord::Migration[5.1]
  def change
    create_table :sleeps do |t|
      t.date :date_of_wakeup
      t.integer :deep_minutes
      t.integer :light_minutes
      t.integer :rem_minutes
      t.integer :wake_minutes
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
