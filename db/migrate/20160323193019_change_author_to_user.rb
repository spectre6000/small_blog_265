class ChangeAuthorToUser < ActiveRecord::Migration
  def change
    rename_table :authors, :users
  end
end
