class AddAvatarColumnsToCreators < ActiveRecord::Migration
  def self.up
    add_attachment :creators, :avatar
  end

  def self.down
    remove_attachment :creators, :avatar
  end
end
