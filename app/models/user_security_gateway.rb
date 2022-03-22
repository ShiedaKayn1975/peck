class UserSecurityGateway < ApplicationRecord
  belongs_to :security_gateway
  belongs_to :user
end
