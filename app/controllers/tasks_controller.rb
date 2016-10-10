class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @today_tasks = Task.today.not_finished
    @not_today_tasks = Task.not_today.not_finished
  end

  def complete
    @finished_today_tasks = Task.today.finished
    @finished_not_today_tasks = Task.not_today.finished
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
    not_sent_today_tasks = Task.today.done
    return redirect_to complete_tasks_path, notice: "all tasks were sent" if not_sent_today_tasks.blank?
    grouped_tasks = not_sent_today_tasks.group_by{ |task| task.purpose }
    text = ""
    if grouped_tasks["work"].present?
      text << "【業務】 \n"
      grouped_tasks["work"].each do |work_task|
        text <<
        "#{work_task.title}  #{work_task.date} \n"
      end
    end
    if grouped_tasks["challenge"].present?
      text << "【チャレンジ】 \n"
      grouped_tasks["challenge"].each do |challenge_task|
        text <<
        "#{challenge_task.title}  #{challenge_task.date} \n"
      end
    end
    if grouped_tasks["study"].present?
      text << "【学習】 \n"
      grouped_tasks["study"].each do |study_task|
        text <<
        "#{study_task.title}  #{study_task.date} \n"
      end
    end

    Slack.send_message(text)

    not_sent_today_tasks.update_all(progress: :sent)

    redirect_to complete_tasks_path
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(
        :title, :date, :plan_time, :actual_time, :importance,
        :urgency, :progress, :frequency, :memo, :purpose
      )
    end
end
