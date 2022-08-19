class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_create :update_post_like_counter

  def update_post_like_counter
    post.likes_counter = 0 unless post.likes_counter?
    post.likes_counter += 1
    post.save
  end
end
