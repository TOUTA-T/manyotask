class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: "DESC")
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
    params.require(:task).permit(:name, :detail)
  end
end
