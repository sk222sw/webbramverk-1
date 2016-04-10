class App < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :name, presence: true, length: { minimum: 2 }

    before_create :generate_key

    private
    
    def generate_key
        self.api_key = SecureRandom.urlsafe_base64
    end
end
