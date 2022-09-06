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

    respond_to do |format|
      format.html
      format.json { render json: @post.comments }
    end
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    parameters = post_params
    respond_to do |format|
      format.json do
        authenticate_request
        post = Post.new(user_id: current_user.id, title: parameters[:title], text: parameters[:text],
                        comments_counter: 0,
                        likes_counter: 0)
        render json: "New Post created by #{current_user.name}" if post.save
      end
      format.html do
        post = Post.new(user_id: current_user.id, title: parameters[:title], text: parameters[:text],
                        comments_counter: 0,
                        likes_counter: 0)
        if post.save
          redirect_to user_path(current_user)
        else
          redirect_to new_user_post_path
        end
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "Post ##{params[:id]} has been deleted"
    redirect_to user_posts_path(current_user)
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
