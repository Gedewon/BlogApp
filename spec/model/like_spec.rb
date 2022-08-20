require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                              bio: 'Teacher from Mexico.', post_counter: 0)
    @first_user.save

    @post = Post.create(author_id: @first_user.id, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
    @post.save

    @like = Like.create(post_id: @post.id, author_id: @first_user.id)
    @like.save
  end
  context 'Likes validations' do
    it 'validate update_likes_counter method' do
      @like.update_likes_counter
      expect(@like.post.likes_counter).to be > 0
    end
    it 'Must belog to a user' do
      @like.author_id = nil
      expect(@like).to_not be_valid
    end

    it 'Must belog to a post' do
      @like.post_id = nil
      expect(@like).to_not be_valid
    end
  end
end
