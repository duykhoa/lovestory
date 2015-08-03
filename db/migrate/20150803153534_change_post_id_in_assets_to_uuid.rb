class ChangePostIdInAssetsToUuid < ActiveRecord::Migration
  def up
    change_column :posts, :id, :uuid, default: 'uuid_generate_v1()'
  end

  def down
    change_column :posts, :id, :integer
  end
end
