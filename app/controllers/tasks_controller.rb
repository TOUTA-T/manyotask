class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    # binding.irb
    if params[:name].present? && params[:status].present?
      @tasks = Task.where('name LIKE ?', "%#{params[:name]}%") .where(status: "#{params[:status]}")
    elsif params[:name].present?
      @tasks = Task.where('name LIKE ?', "%#{params[:name]}%")
    elsif params[:status].present?
      @tasks = Task.where(status: "#{params[:status]}")
    else
      @tasks = Task.order(created_at: :desc)
    end

    if params[:deadline_sort]
      @tasks = @tasks.order(deadline: :asc)
    elsif
      params[:status_sort]
      @tasks = @tasks.order(status: :asc)
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
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority)
  end

end
