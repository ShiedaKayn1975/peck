class User < ApplicationRecord
  include SecureTokens
  include Actionable

  module Status
    ACTIVE = 'active'
    DISABLED = 'disabled'
    VALIDATING = 'validating'
  end

  enumerize :status,
  in: Status.constants.map { |const| Status.const_get(const) }, 
  predicates: true

  scope :active, -> { where(status: Status::ACTIVE) }
  scope :disabled, -> { where(status: Status::DISABLED) }
  scope :validating, -> { where(status: Status::VALIDATING)}

  has_secure_password
  has_secure_tokens

  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false

  action :commit_security_gateway do
    label "Commit secuity gateway"

    show? do |object, context|
      true
    end

    authorized? do |object, context|
      true
    end

    commitable? do |object, context|
      true
    end

    commit do |object, context|
      data = context.data
      security_code = data['security_code']
      security_step = data['security_step']
      commit_data = data['data']

      security = SecurityGateway.find_by(code: security_code)
      user_security = UserSecurityGateway.find_by(user_id: context.actor.id)

      raise InvalidDataError.new("You're not in any security gateway") unless user_security
      raise InvalidDataError.new("Action error") unless security
      raise InvalidDataError.new("Invalid action") unless security.id == user_security.security_gateway_id
      raise InvalidDataError.new("Invalid action") unless security_step['index'] == user_security.current_step

      current_security = security.steps[user_security.current_step]
      if current_security['code'] == 'phone'
        raise InvalidDataError.new("Invalid phone number") if (commit_data['phone'] =~ /^(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}$/).blank?
        object.phone = commit_data['phone']
        object.save
      elsif current_security['code'] == 'birthday'
        object.birthday = commit_data['birthday'].to_datetime
        object.save
      else
        raise InvalidDataError.new("Invalid action")
      end

      user_security.status = 'done' if user_security.current_step == security.steps.length - 1
      user_security.current_step = user_security.current_step + 1

      user_security.save!
    end
  end

  action :ignore_security_gateway do
    label "Ignore security gateway"

    show? do |object, context|
      true
    end

    authorized? do |object, context|
      true
    end

    commitable? do |object, context|
      true
    end

    commit do |object, context|
      data = context.data
      security_code = data['security_code']
      security_step = data['security_step']

      security = SecurityGateway.find_by(code: security_code)
      user_security = UserSecurityGateway.find_by(user_id: context.actor.id)

      raise InvalidDataError.new("You're not in any security gateway") unless user_security
      raise InvalidDataError.new("Action error") unless security
      raise InvalidDataError.new("Invalid action") unless security.id == user_security.security_gateway_id
      raise InvalidDataError.new("Invalid action") unless security_step['index'] == user_security.current_step

      step = security.steps[security_step['index']]
      raise InvalidDataError.new("You cannot ignore this step!") unless step['ignorable']
      
      user_security.status = 'done' if user_security.current_step == security.steps.length - 1
      user_security.current_step = user_security.current_step + 1

      user_security.save!
    end
  end

  action :send_activation_email do
    label "Send activation email"

    show? do |object, context|
      true
    end

    authorized? do |object, context|
      true
    end

    commitable? do |object, context|
      true
    end
    
    commit do |object, context|
      object.send_activation_email
    end
  end

  action :switch_app do
    label "Send activation email"

    show? do |object, context|
      false
    end

    authorized? do |object, context|
      object.id == context[:actor].id
    end

    commitable? do |object, context|
      true
    end
    
    commit do |object, context|
      object.current_app = context[:data]["app"]
      object.save
    end
  end
    
  # def self.find_in_cache uid, token

  # end
  def send_activation_email
    token = generate_activation_token
    UserMailer.activation(self, token).deliver_later
  end

  def generate_activation_token
    JsonWebToken.new.encode({
      sub: self.id,
      iat: Time.now.to_i,
      expired_at: 1.hour.from_now.to_i
    })
  end
end
