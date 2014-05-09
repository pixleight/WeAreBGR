class AddAccountsToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :accounts, :text
  end
end
