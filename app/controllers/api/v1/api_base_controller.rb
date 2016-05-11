class Api::V1::ApiBaseController < ApplicationController
    include Knock::Authenticable
    protect_from_forgery with: :null_session
    
    before_action :validate_api_key
    
    private
        def validate_api_key
            api_key = request.headers["Api-Key"]
            @app = App.where(api_key: api_key).first if api_key
            unless @app
                render json: { error: "API-Key is not valid." }, status: :unauthorized
            end
        end
end
