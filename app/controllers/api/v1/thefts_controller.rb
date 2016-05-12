require "uri"

class Api::V1::TheftsController < Api::V1::ApiBaseController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate, only: [:index, :show]
    respond_to :json
    
    def index
        if Theft.any?
            if params[:description]
                description = params[:description]
                respond_with Theft.where("description like ?", "%#{description}%")
            else
                respond_with Theft.all
            end
        else
            render json: { error: "Sorry :( no thefts yet... Wait, that's actually a good thing.", status: :not_found }
        end
    end
    
    def show
       respond_with Theft.find(params[:id])
    end
    
    def create
        return unless position_provided?
        
        theft = Theft.new(theft_params.except(:longitude, :latitude, :tags))
        
        if tags = theft_params[:tags]
            tags.each do |tag|
                theft.tags << Tag.where(tag).first_or_create
            end
        end
        
        theft.creator = current_user

        position = Position.new
        position.longitude = theft_params[:longitude]
        position.latitude = theft_params[:latitude]
        
        theft.position = position
        
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
            json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
            json_params.require(:theft).permit(:description, :time, :longitude, :latitude, tags: [:name])
        end
    
        # checking if a position was provided in the body parameters
        def position_provided?
            if theft_params[:longitude].blank? || theft_params[:latitude].blank?
                render json: { error: "Please provide a position" }
                return false
            else
                return true
            end
        end
    
end
