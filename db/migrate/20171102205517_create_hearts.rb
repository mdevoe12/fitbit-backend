class CreateHearts < ActiveRecord::Migration[5.1]
  def change
    create_table :hearts do |t|
      t.date :date
      t.integer :resting_heart_rate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
