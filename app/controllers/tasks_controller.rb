class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @today_tasks = Task.today.doing
    @not_today_tasks = Task.not_today.doing
  end

  def complete
    @today_tasks = Task.today.done
    @not_today_tasks = Task.not_today.done
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
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  def slack
    @today_tasks = Task.today.done
    @today_tasks.update_all(progress: :sent)
    text = "学習 \n"
    params[:tasks].keys.each do |id|
      text <<
      "#{params[:tasks][id][:title]}  #{params[:tasks][id][:date]} \n"
    end

    Slack.send_message(text)

    redirect_to complete_tasks_path
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(
        :title, :date, :plan_time, :actual_time,
        :importance, :urgency, :progress, :frequency, :memo
      )
    end
end
