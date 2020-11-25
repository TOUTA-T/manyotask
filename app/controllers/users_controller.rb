class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @posts = @user.posts
  end

  def edit
    if @current_user.id !=  params[:id].to_i
      redirect_to new_session_path, notice: '編集権限がありません'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end

end
