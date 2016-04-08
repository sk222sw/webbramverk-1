class User < ActiveRecord::Base
    has_secure_password
    has_many :apps
    
    validates :email,
              :presence => {:message => "du måste ange epost"},
              uniqueness: true
              
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                        :presence => {:message => "felaktig epost"}
    has_secure_password
    validates :password, presence: true, length: { minimum: 1 }
    
end
