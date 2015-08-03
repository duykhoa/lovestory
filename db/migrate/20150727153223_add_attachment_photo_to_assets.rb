class AddAttachmentPhotoToAssets < ActiveRecord::Migration
  def self.up
    change_table :assets do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :assets, :photo
  end
end
