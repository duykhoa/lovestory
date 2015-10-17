class AddSlugToLovePages < ActiveRecord::Migration
  def change
    add_column :love_pages, :slug, :string

    add_index :love_pages, :slug, unique: true
  end
end
