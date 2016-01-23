class AddDeletedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :deleted_at, :datetime, default: nil
  end
end
