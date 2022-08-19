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
end
