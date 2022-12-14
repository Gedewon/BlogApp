require 'rails_helper'

RSpec.describe 'User pages functionality : user show page' do
  let!(:user) do
    User.create(name: 'Maqueen', photo: 'https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=20&m=1223671392&s=612x612&w=0&h=lGpj2vWAI3WUT1JeJWm1PRoHT3V15_1pdcTn2szdwQ0=',
                bio: 'Programer in headquaters', postscounter: 0)
  end

  let!(:p1) do
    Post.create(user_id: user.id, title: 'Post test', text: 'Yes its just a test',
                comments_counter: 0, likes_counter: 0)
  end

  before(:each) do
    visit user_path(user)
  end
  it "I can see the user's profile picture" do
    expect(page).to have_xpath("//img[@src='#{user.photo}']")
  end
  it "I can see the user's username" do
    expect(page).to have_text(user.name)
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content(/posts:[\d+]/i)
  end

  it "I can see the user's bio." do
    expect(page).to have_content(/#{user.bio}/i)
  end

  it "I can see a button that lets me view all of a user's posts." do
    expect(page).to have_text(/See all posts/i)
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    visit user_posts_path(user)
    within 'div#postlink' do
      click_link
      expect(page).to have_current_path(user_post_path(user, p1))
    end
  end

  it "When I click to see all posts, it redirects me to the user's post's index page" do
    visit user_post_path(user, p1)
    click_on 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
