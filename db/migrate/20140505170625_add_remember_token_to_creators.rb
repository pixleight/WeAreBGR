class AddRememberTokenToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :remember_token, :string
    add_index :creators, :remember_token
  end
end
