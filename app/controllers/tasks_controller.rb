class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    #controller検索→ 検索機能をモデルにつけている
    @tasks = Task.all.kaminari_page(params[:page])

    if params[:name].present? && params[:status].present?
      @tasks = @tasks.double params[:name],params[:status]
      # Task.where('name LIKE ?', "%#{params[:name]}%") .where(status: "#{params[:status]}")
    elsif params[:name].present?
      @tasks = @tasks.name_like params[:name]
      # Task.where('name LIKE ?', "%#{params[:name]}%")
    elsif params[:status].present?
      @tasks = @tasks.status params[:status]
      # Task.where(status: "#{params[:status]}")
    else
      @tasks = Task.kaminari_page(params[:page]).order(created_at: :desc)
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

  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task), notice:"投稿されました！"
    else
      render :new
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
