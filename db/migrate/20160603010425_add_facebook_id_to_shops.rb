class AddFacebookIdToShops < ActiveRecord::Migration
  def change
    add_column :shops, :facebook_id, :bigint
    add_index :shops, :facebook_id, unique: true
  end
end
