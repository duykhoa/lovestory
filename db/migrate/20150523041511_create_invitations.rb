class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations, id: :uuid do |t|
      t.integer :love_page_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
