# Create articles
class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.date :release_date
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
