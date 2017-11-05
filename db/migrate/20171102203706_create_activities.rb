class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.date :date
      t.integer :active_calories_out
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
