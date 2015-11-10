class AddAttachmentProfileImageToAuthors < ActiveRecord::Migration
  def up
    add_attachment :authors, :profile_image
  end

  def down
    remove_attachment :authors, :profile_image
  end
end
