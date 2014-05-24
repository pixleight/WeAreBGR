class AddCityToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :city, :string
  end
end
