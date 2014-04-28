class CommentsController < ApplicationController
  before_action :require_user, :set_post

  def create
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Your post has been created"
      redirect_to post_path(@post)
    else
      render "posts/show"
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])

    if @vote.save
      flash[:notice] = "Your vote has been counted"
    else
      flash[:error] = "You have already voted on this"
    end
    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end