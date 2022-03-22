class User < ApplicationRecord
    include SecureTokens

    module Status
        ACTIVE = 'active'
        DISABLED = 'disabled'
        VALIDATING = 'validating'
    end

    has_secure_password
    has_secure_tokens

    validates_presence_of :email
    validates_uniqueness_of :email, case_sensitive: false
    
    # def self.find_in_cache uid, token

    # end
end
