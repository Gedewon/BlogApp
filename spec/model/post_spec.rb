require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.', postscounter: 0)
    @first_user.save

    @post = Post.create(user_id: @first_user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
    @post.save
  end
  context 'Posts validations' do
    it 'Title must not be blank.' do
      @post.title = ''
      expect(@post).to_not be_valid
    end

    it 'Title must not exceed 250 characters' do
      @post.title = 'A' * 251
      expect(@post).to_not be_valid
    end

    it 'CommentsCounter must be an integer greater than or equal to zero' do
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end

    it 'LikesCounter must be an integer greater than or equal to zero.' do
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end

    it 'PostsCounter must be an integer greater than or equal to zero.' do
      @post.update_user_post_counter
      @post.save
      expect(@post.author.postscounter).to be > 0
    end
  end
end
