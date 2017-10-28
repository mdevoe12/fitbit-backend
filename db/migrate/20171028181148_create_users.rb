class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.integer :age
      t.integer :height
      t.text :token
      t.text :refresh_token

      t.timestamps
    end
  end
end
