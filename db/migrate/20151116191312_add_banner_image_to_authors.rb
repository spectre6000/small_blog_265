class AddBannerImageToAuthors < ActiveRecord::Migration
  def up
    add_attachment :authors, :banner_image
  end

  def down
    remove_attachment :authors, :banner_image
  end
end
