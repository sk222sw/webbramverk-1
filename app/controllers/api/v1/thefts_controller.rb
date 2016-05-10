class Api::V1::TheftsController < Api::V1::ApiBaseController
    skip_before_action :verify_authenticity_token
    respond_to :json
    
    def index
        respond_with Theft.all
    #   render json: { error: "Sorry :( no thefts yet... Wait, that's actually a good thing.", status: :not_found }
    end
    
    def show
       respond_with Theft.find(params[:id])
    end
    
      def create
        theft = Theft.new(theft_params)
        if theft.save
          render json: theft, status: 201, location: [:api, theft]
        else
          render json: { errors: theft.errors }, status: 422
        end
      end
    
      private
    
        def theft_params
          params.require(:theft).permit(:time, :description)
        end
    
end
