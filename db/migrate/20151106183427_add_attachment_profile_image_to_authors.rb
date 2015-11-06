class AddAttachmentProfileImageToAuthors < ActiveRecord::Migration
  def self.up
    change_table :authors do |t|
      t.attachment :profile_image
      t.attachment :banner_image
    end
  end

  def self.down
    remove_attachment :authors, :profile_image
    remove_attachment :authors, :banner_image
  end
end
