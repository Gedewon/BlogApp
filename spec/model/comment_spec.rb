require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                        bio: 'Teacher from Mexico.', postscounter: 0)
    @user.save
    @post = Post.create(user_id: @user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
    @post.save
    @comment = Comment.create(text: 'This is my first comment', post_id: @post.id, user_id: @user.id)
    @comment.save
  end

  it 'Must belog to a user' do
    @comment.user_id = nil
    expect(@comment).to_not be_valid
  end

  it 'Must belog to a post' do
    @comment.post_id = nil
    expect(@comment).to_not be_valid
  end

  it 'Will increase the post comments_counter' do
    @comment.update_post_comment_counter
    expect(@comment.post.comments_counter).to eq 2
  end
end
