class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.uuid :post_id
      t.string :thumb_url
      t.string :url
    end
  end
end
