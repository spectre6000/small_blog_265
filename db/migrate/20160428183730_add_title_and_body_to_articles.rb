class AddTitleAndBodyToArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.string     :title
      t.text       :body
    end
  end
end
