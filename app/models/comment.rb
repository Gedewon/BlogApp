class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  alias_attribute :author, :user
  after_create :update_post_comment_counter

  def update_post_comment_counter
    post.comments_counter = 0 unless post.comments_counter?
    post.comments_counter += 1
    post.save
  end
end
