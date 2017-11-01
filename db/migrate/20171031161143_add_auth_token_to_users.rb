class AddAuthTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :auth_token, :string
    add_index :users, :auth_token
  end
end
