# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_task!, only: %i[show update]
  def index
    tasks = Task.all
    render status: :ok, json: { tasks: tasks }
  end

  def show
    respond_with_json({ task: @task })
  end

  def update
    @task.update!(task_params)
    respond_with_success(t("successfully_updated"))
  end

  def create
    task = Task.new(task_params)
    task.save!
    render status: :ok, json: { notice: t("successfully_created") }
  end

  private

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end

    def task_params
      params.require(:task).permit(:title)
    end
end
