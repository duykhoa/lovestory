class AddTitleToLovePages < ActiveRecord::Migration
  def change
    add_column :love_pages, :title, :string
  end
end
