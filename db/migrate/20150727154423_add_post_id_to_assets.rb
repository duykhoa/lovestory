class AddPostIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :post_id, :integer
  end
end
