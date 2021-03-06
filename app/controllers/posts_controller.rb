class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:create, :edit, :update]

  def index
    @posts = Post.all.sort_by{|e| e.total_votes}.reverse
  end

  def show
    @comment = Comment.new 
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Your post has been created"
      redirect_to root_path
    else
      render :new
    end

  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your Post has been updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])

    respond_to do |format|
      
      format.html do
        if @vote.save
          flash[:notice] = "Your vote has been counted"
        else
          flash[:error] = "You have already voted on this"
        end
        redirect_to :back
      end

      format.js
      
    end

    
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :url, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def require_creator
    access_denied unless @post.user == current_user or current_user.admin?
  end

end
