class Api::V1::MeController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def profile
    # security_gateway = SecurityGateway.joins("INNER JOIN user_security_gateways ON user_security_gateways.security_gateway_id = security_gateways.id").
    #   where('user_security_gateways.status = ? AND user_security_gateways.user_id = ?', 'doing', current_user.id).first()

    result = {
      user: current_user.as_json(
        except: [:password_digest]
      )
    }
    user_security_gateway = UserSecurityGateway.find_by(user_id: current_user.id, status: 'doing')
    if user_security_gateway
      security_gateway = SecurityGateway.find_by(id: user_security_gateway.security_gateway_id)
      result[:security_gateways] = security_gateway.as_json(except: [:created_at, :updated_at, :id])
      result[:current_step] = user_security_gateway.current_step
    end

    render json: result
  end
end
