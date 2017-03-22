class V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :validate_user, only: [:update, :destroy]
  before_action :validate_type, only: [:create, :update]
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
      render json: user, status: :created
    else
      render_error(user, :unprocessable_entity)
    end
  end

  def update
    if @user.update_attributes(user_params)
      render json: @user, status: 200
    else
      render_error(@user, :unprocessable_entity)
    end
  end

  def destroy
    @user.destroy
    head(204)
  end
    
  private

    def user_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params)
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
