class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::Helpers
  include ActionController::Serialization
  # before_action :require_login!
  helper_method :current_user

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

    def check_header
      if ['POST', 'PUT', 'PATCH'].include? request.method
        if request.content_type != "application/vnd.api+json"
          head 406 and return
        end
      end
    end

    def validate_type
      if params['data'] && params['data']['type']
        if params['data']['type'] == params[:controller]
          return true
        end
      end
      head 409 and return
    end

    def validate_user
      token = request.headers["X-API-Key"]
      head 403 and return unless token
      user = User.find_by(auth_token: token)
      head 403 and return unless user
    end

    def render_error(resource, status)
      render json: resource, status: status, adapter: :json_api,
            serializer: ActiveModel::Serializer::ErrorSerializer
    end
end
