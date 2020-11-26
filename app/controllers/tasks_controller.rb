class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :autenticate_user, only: [:edit, :update, :destroy]

  def index
    unless @current_user
      redirect_to new_session_path, notice: 'ログインしていないと、一覧は見れません'
    end
    @tasks = current_user.tasks.kaminari_page(params[:page])
    if params[:name].present? && params[:status].present?
      @tasks = @tasks.double params[:name],params[:status]
    elsif params[:name].present?
      @tasks = @tasks.name_like params[:name]
    elsif params[:status].present?
      @tasks = @tasks.status params[:status]
    else
      @tasks = @tasks.order(created_at: :desc)
    end

    if params[:deadline_sort]
      @tasks = @tasks.kaminari_page(params[:page]).order(deadline: :asc)
    elsif
      params[:status_sort]
      @tasks = @tasks.kaminari_page(params[:page]).order(status: :asc)
    else

    end
  end

  def search

  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
    if @task.user == @current_user
     render "edit"
    else
     redirect_to new_session_path, notice: '編集権限がありません'
 end
  end

  def create
    unless @current_user
      redirect_to new_session_path, notice: 'ログインしていないと、投稿できません'
    else
      @task = @current_user.tasks.build(task_params)
      if params[:back]
        render :new
      else
        if @task.save
          redirect_to task_path(@task), notice:"投稿されました！"
        else
          render :new
        end
      end
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice:"編集は正常に行われました"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
      redirect_to tasks_path, notice:"削除しました"
  end

  private
  def set_task
    @task =Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority, :page)
  end

end
