class Creator < ActiveRecord::Base
    has_many :thefts
    has_secure_password
end
