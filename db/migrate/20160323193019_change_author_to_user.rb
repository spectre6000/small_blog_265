# Change authors to users, intent is to move to single table inheritance
class ChangeAuthorToUser < ActiveRecord::Migration
  def change
    rename_table :authors, :users
  end
end
