class User < ActiveRecord::Base
    has_secure_password
    
    validates :email,
              :presence => {:message => "du måste ange epost"},
              uniqueness: true
              
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                        :presence => {:message => "felaktig epost"}
end
