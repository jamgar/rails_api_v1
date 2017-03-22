class V1::SessionsController < ApplicationController
  skip_before_action :require_login!, only: [:create, :destroy]

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      auth_token = user.auth_token
      render json: { auth_token: auth_token }, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = current_user
    user.regenerate_auth_token
    head :ok
  end
end