class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :autenticate_user, only: [:edit, :update, :destroy]

  def index
    if current_user.admin?
      @users = User.select(:id, :name, :admin)
      @users = @users.order(id: :asc)
    else
      redirect_to tasks_path, notice: '管理者以外はアクセスできません'
    end
  end

  def new
    if @current_user
      @user = User.new
    end
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

  def change
    @user = User.find(params[:user])
    if @user.admin == true
      @user.admin = false
    else
      @user.admin = true
    end
    @user.save
    redirect_to admin_users_path, notice:"権限を変更しました"
  end

  def show
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
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

end
