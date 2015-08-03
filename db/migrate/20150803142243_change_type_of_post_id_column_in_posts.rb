class ChangeTypeOfPostIdColumnInPosts < ActiveRecord::Migration
  def up
    remove_column :posts, :id
    add_column :posts, :id, :uuid, default: 'uuid_generate_v1()'
    execute %Q{ ALTER TABLE "posts" ADD PRIMARY KEY ("id"); }
  end
  def down
    remove_column :posts, :id
    add_column :posts, :id, :primary_key
  end
end
