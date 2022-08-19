class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  alias_attribute :author, :user

  after_create :update_user_post_counter

  def update_user_post_counter
    user.postscounter = 0 unless user.postscounter?
    user.postscounter += 1
    user.save
  end

  def most_recent_post
    Comment.where(user: self).order(created_at: :desc).limit(5)
  end
end
