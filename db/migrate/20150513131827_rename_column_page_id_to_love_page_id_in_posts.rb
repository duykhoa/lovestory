class RenameColumnPageIdToLovePageIdInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :page_id, :love_page_id
  end
end
