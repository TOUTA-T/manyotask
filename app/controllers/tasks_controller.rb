class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :create]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    # @post = current_user.tasks.build(post_params)
  end

  def update
  end

  def destroy
  end

  private
  def set_task
    @task =Task.find(oarams[:id])
  end

end
