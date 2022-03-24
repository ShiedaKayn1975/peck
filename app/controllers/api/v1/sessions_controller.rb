class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]
  DISABLED_LOGIN_MESSAGE='Your account is disabled'.freeze

  def create
    if params[:email].blank? || params[:password].blank?
      return
    end

    user = User.find_by(email: params[:email].to_s.downcase)
    if user&.authenticate(params[:password]) && (token = user.generate_token)
      if user.disabled?
        render_error(DISABLED_LOGIN_MESSAGE, :bad_request) 
        return
      end

      render json: { token: token }, status: :ok
    else
      render_error 'Wrong email or password', :unauthorized
    end
  end
end
