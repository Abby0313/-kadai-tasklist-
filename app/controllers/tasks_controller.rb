class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user
  #  before_action :correct_user, only: [:index, :show,:create,:edit,:update,:destroy]

  def index
    @tasks = current_user.tasks.all.page(params[:page])
#    @tasks = Task.all.page(params[:page])
  end

  def show
#    @task = current_user.tasks.find_by(id: params[:id])
    set_task
  end

  def new
    @task = current_user.tasks.new
#    @task = Task.new
  end

  def create
#    @task = Task.new(tasks_params)
    @task = current_user.tasks.build(tasks_params)

    if @task.save
      flash[:success] = 'タスクが正常に投稿されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが投稿されませんでした'
      render :new 
    end
  end

  def edit
    set_task
  end

  def update
    set_task

    if @task.update(tasks_params)
      flash[:success] = 'タスクは正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy

    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
    def set_task
#    @task = Task.find(params[:id])
#    @task = current_user.tasks.find(params[:id])
    puts 'pass1'
    @task = current_user.tasks.find_by(id: params[:id])
    puts 'pass2'
    puts @task
    puts 'pass3'
      unless @task
          puts 'pass4'

        redirect_to root_url
      end
    puts 'pass5'
    end

    # Strong Parameter
    def tasks_params
      params.require(:task).permit(:content, :status)
    end
    
    def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
      unless @task
#       redirect_to root_url
      end
  end
end
  