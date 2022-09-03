class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:comments, :user).where(user: @user)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.includes(:comments, :user).find_by(user_id: params[:user_id], id: params[:id])
    @user = current_user
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    parameters = post_params
    post = Post.new(user_id: current_user.id, title: parameters[:title], text: parameters[:text], comments_counter: 0,
                    likes_counter: 0)
    post.save
    # post.update_posts_counter
    if post.save
      # puts "Saved successfully"
      redirect_to user_path(current_user)
    else
      # puts "Failed to save"
      redirect_to new_user_post_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
