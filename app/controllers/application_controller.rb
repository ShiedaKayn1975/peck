class ApplicationController < ActionController::Base
  private

  def render_error(message, status = :bad_request)
    Rails.logger.warn { message }
    render json: { errors: [{ detail: message }] }, status: status
  end
end
