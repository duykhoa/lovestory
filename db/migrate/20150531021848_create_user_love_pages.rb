class CreateUserLovePages < ActiveRecord::Migration
  def change
    create_table :user_love_pages do |t|
      t.integer :user_id
      t.integer :love_page_id
    end
  end
end
