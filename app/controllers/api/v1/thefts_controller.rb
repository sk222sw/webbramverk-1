class Api::V1::TheftsController < Api::V1::ApiBaseController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate, only: [:index, :show]
    respond_to :json
    
    def index
        if Theft.any?
            if params[:creator_id]
                respond_with Theft.all
            else
                render json: { error: "MJAAAU", status: :not_found }
            end
        else
            render json: { error: "Sorry :( no thefts yet... Wait, that's actually a good thing.", status: :not_found }
        end
    end
    
    def show
       respond_with Theft.find(params[:id])
    end
    
    def create
        theft = Theft.new(theft_params)

        theft.creator = current_user
        
        if theft.save
            render json: theft, status: 201, location: [:api, theft]
        else
            render json: { errors: theft.errors }, status: 422
        end
    end
    
    def update
        theft = Theft.find(params[:id])
        
        if theft.update(theft_params)
            render json: theft, status: 200, location: [:api, theft]
        else
            render json: { errors: theft.errors }, status: 422
        end
    end
    
    def destroy
        theft = Theft.find(params[:id])
        
        theft.destroy
        render json: { action: "destroy", message: "Theft removed, ID: #{params[:id]} (hopefully a lost bike was returned to it's owner)"}
    end
    
      private
    
        def theft_params
          params.require(:theft).permit(:time, :description)
        end
    
end
