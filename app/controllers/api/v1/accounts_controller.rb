class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    @account = Account.new(registration_params)
    @account.status = User::Status::VALIDATING

    if @account.save
      token = @account.generate_token

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
