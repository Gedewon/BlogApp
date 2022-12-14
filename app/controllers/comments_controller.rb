class CommentsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = User.includes(:posts, :comments).find(params[:user_id]).posts.find(params[:post_id])
    @comments = @post.most_recent_post
  end

  def create
    parameters = comment_params

    respond_to do |format|
      format.json do
        authenticate_request
        comment = Comment.new(post_id: params[:post_id], user_id: current_user.id, text: parameters[:text])
        comment.save
        render json: "New Comment Added By #{current_user.name}"
      end
      format.html do
        comment = Comment.new(post_id: params[:post_id], user_id: current_user.id, text: parameters[:text])
        comment.save
        if comment.save
          redirect_to user_post_path(id: params[:post_id])
        else
          redirect_to new_user_post_comment
        end
      end
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "Comment ##{params[:id]} has been deleted"
    redirect_back(fallback_location: root_path)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
