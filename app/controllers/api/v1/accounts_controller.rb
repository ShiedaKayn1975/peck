class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  INITIAL_STEP = 1

  def create
    @account = Account.new(registration_params)
    @account.status = User::Status::VALIDATING
    security_gateway = SecurityGateway.find_by(code: 'account_setup')

    if @account.save
      token = @account.generate_token      

      if security_gateway.blank?
        @account.status = User::Status::ACTIVE
        @account.save
      else
        UserSecurityGateway.create(
          security_gateway_id: security_gateway.id,
          user_id: @account.id,
          current_step: INITIAL_STEP,
          status: 'doing'
        )
      end

      render json: {
        account: @account.as_json(except: [
          :id, :password_digest
        ]),
        token: token
      }, status: :ok
    else
      render_error @account.errors.full_messages
    end
  end

  private

  def registration_params
    params.permit(:email, :password, :password_confirmation)
  end
end
