class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes
  # validations for name and post_counter

  validates :name, presence: true
  validates :postscounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  def most_recent_post
    Post.where(user: self).order(created_at: :desc).limit(3)
  end
end
