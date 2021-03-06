# Model for Articles/blog posts
class Article < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true

  belongs_to :user
end
