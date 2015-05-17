class RemoveAccounts < ActiveRecord::Migration
  def up
    drop_table :accounts
  end
end
