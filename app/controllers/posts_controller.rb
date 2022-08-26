class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(:comments, :user).where(user: @user)
  end

  def show
    @post = Post.includes(:comments, :user).find_by(user_id: params[:user_id], id: params[:id])
  end
end
