class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Helpers
  include ActionController::Serialization
  # before_action :require_login!
  helper_method :user_signed_in?, :current_user

  # def user_signed_in?
  #   current_user.present?
  # end
  
  # def require_login!
  #   return true if authenticate_token
  #   render json: { errors: [ { detail: "Access denied" } ] }, status: 401
  # end

  def current_user
    @current_user ||= User.find_by(auth_token: params[:token])
  end

  private

    def render_error(resource, status)
      render json: resource, status: status, adapter: :json_api,
            serializer: ActiveModel::Serializer::ErrorSerializer
    end
end
