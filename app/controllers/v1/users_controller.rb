class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  # before_action :authenticate, only: [:show, :update, :destroy]

  def index
    users = User.all
    render json: users
  end
  
  def show
    # @user = User.find(params[:id])
    render json: @user, status: :ok
  end
    
  def create
    user = User.new(user_params)
    if user.save
      render json: {status: 'User created successfully'}, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: 200
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @user.destroy
    head(204)
  end
    
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        user = User.new
        user.errors.add(:id, "Wrong ID provided")
        render_error(user, 404) and return
      end
    end
       
end
