class AddIndexToCreatorsEmail < ActiveRecord::Migration
  def change
    add_index :creators, :email, unique: true
  end
end
