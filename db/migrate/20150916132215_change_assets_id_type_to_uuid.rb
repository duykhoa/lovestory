class ChangeAssetsIdTypeToUuid < ActiveRecord::Migration
  def up
    remove_column :assets, :id
    add_column :assets, :id, :uuid, default: 'uuid_generate_v1()'

    execute %Q{ ALTER TABLE "assets" ADD PRIMARY KEY ("id"); }

    remove_column :assets, :post_id
    add_column :assets, :post_id, :uuid
  end
end
