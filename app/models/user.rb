class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes

  def most_recent_post
    Post.where(user:self).order(created_at: :desc).limit(3)
  end
end
