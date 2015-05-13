class ChangePagesToLovePages < ActiveRecord::Migration
  def change
    rename_table :pages, :love_pages
  end
end
