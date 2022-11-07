# frozen_string_literal: true

class TasksController < ApplicationController
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :load_task!, only: %i[show update destroy]
  def index
    tasks = policy_scope(Task)
    tasks_with_assigned_user = tasks.as_json(include: { assigned_user: { only: %i[name id] } })
    respond_with_json({ tasks: tasks_with_assigned_user })
  end

  def show
    authorize @task
    @comments = @task.comments.order("created_at DESC")
  end

  def update
    authorize @task
    @task.update!(task_params)
    respond_with_success(t("successfully_updated", entity: "Task"))
  end

  def destroy
    authorize @task
    @task.destroy!
    respond_with_json
  end

  def create
    task = current_user.created_tasks.new(task_params)
    authorize task
    task.save!
    respond_with_success(t("successfully_created", entity: "Task"))
  end

  private

    def load_task!
      @task = Task.find_by!(slug: params[:slug])
    end

    def task_params
      params.require(:task).permit(:title, :assigned_user_id)
    end
end
