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
      
      binding.pry
      
    end
  end
    
  # def self.find_in_cache uid, token

  # end
end
