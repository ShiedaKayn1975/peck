class User < ApplicationRecord
  include SecureTokens

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
    
  # def self.find_in_cache uid, token

  # end
end
