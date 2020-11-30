class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :autenticate_user, only: [:edit, :update, :destroy]

  def new
    if @current_user
      redirect_to tasks_path, notice: 'ログイン中は新規ユーザー登録は出来ません。ログアウトして下さい。'
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "#{@user.name}でログインしました！"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    if @user != @current_user
      redirect_to tasks_path, notice: '他の人のマイページは見れません'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice:"編集は正常に行われました"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
      redirect_to admin_users_path, notice:"削除しました"
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end

end
