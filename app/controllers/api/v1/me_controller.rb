class Api::V1::MeController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def profile
    render json: current_user.as_json(
      except: [:password_digest]
    )
  end
end
