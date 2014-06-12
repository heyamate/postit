class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create, :show]
  before_action :set_user, except: [:new, :create]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Your user account has been created"
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account details have been updated"
      render :edit
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end

  def set_user
    @user = User.find_by slug: params[:id]
  end

  def require_same_user
    if @user != current_user
      flash[:error] = "You can only modify your own profile"
      redirect_to root_path
    end
  end
end