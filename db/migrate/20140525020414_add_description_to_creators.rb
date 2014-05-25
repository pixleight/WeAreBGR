class AddDescriptionToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :description, :text
  end
end
