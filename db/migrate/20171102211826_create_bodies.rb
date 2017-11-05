class CreateBodies < ActiveRecord::Migration[5.1]
  def change
    create_table :bodies do |t|
      t.date :date
      t.float :body_fat
      t.float :bmi
      t.float :weight
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
