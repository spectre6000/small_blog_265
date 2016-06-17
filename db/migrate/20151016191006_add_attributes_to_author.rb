# add additional information to author class
class AddAttributesToAuthor < ActiveRecord::Migration
  def change
    change_table :authors do |t|
      t.boolean     :admin, default: false
      t.text        :bio
      t.string      :location
    end
  end
end
