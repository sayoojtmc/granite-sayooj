# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user_using_x_auth_token, only: :create
  def index
    users = User.select(:id, :name)
    render status: :ok, json: { users: users }
  end

  def create
    @user = User.find_by!(email: login_params[:email].downcase)
    unless @user.authenticate(login_params[:password])
      respond_with_error("Incorrect credentials, try again.", :unauthorized)
    end
  end

  private

    def login_params
      params.require(:login).permit(:email, :password)
    end
end
