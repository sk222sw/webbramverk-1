class Api::V1::TheftsController < Api::V1::ApiBaseController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate, only: [:index, :show]
    rescue_from ActiveRecord::RecordNotFound, :with => :resource_not_found
    respond_to :json
    
    ERROR_NO_THEFTS = { error: "Sorry :( no thefts yet... Wait, that's actually a good thing.", status: 404 }
    ERROR_NO_TAG_NAME = { error: "Please provide a name for each tag", status: 400 }
    MESSAGE_THEFT_DELETED = { message: "Theft removed. Hopefully a lost bike was returned to it's owner", status: 200 }
    ERROR_NO_POSITION = { error: "Please provide both longitude and latitude", status: 400 }
    ERROR_POSITION_NOT_VALID = { error: "Longitude and latitude must be numbers and decimals separated with a full stop, eg 2387.3874", status: 400}
    RESOURCE_NOT_FOUND = { error: "No resource with the provided ID could be found.", status: 404}
    
    def index
        if Theft.any?
            if params[:description]
                description = params[:description]
                respond_with Theft.where("description like ?", "%#{description}%")
            elsif params[:tag]
                # i believe this works, but it doesnt show null values
                # TODO: There's probably some Rails magic to simplify this
                query_tag = params[:tag]
                theft_ids = []
                tags = Tag.where(:name => query_tag)

                tags.each do |tag|
                   theft_ids << tag.id 
                end

                thefts = Theft.where(:id => theft_ids)

                respond_with thefts
            else
                respond_with Theft.all
            end
        else
            render json: ERROR_NO_THEFTS
        end
    end
    
    def show
       respond_with Theft.find(params[:id])
    end
    
    def create
        return unless position_provided?
        return unless valid_position_provided?
        
        theft = Theft.new(theft_params.except(:longitude, :latitude, :tags))
        
        if tags = theft_params[:tags]
            tags.each do |tag|
                if tag[:name].blank?
                  render json: ERROR_NO_TAG_NAME
                  return
                end
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
        return unless position_provided?
        return unless valid_position_provided?

        theft = Theft.find(params[:id])
        theft[:position][:longitude] = params[:longitude]
        theft[:position][:latitude] = params[:latitude]
        
        theft.position.longitude = theft_params[:longitude]
        theft.position.latitude = theft_params[:latitude]

        theft.tags = []

        if tags = theft_params[:tags]
            tags.each do |tag|
                if tag[:name].blank?
                  render json: ERROR_NO_TAG_NAME
                  return
                end
                theft.tags << Tag.where(tag).first_or_create
            end
        end

        if theft.update(theft_params.except(:longitude, :latitude, :tags))
            render json: theft, status: 200, location: [:api, theft]
        else
            render json: { errors: theft.errors }, status: 422
        end
    end
    
    def destroy
        theft = Theft.find(params[:id])
        
        theft.destroy
        render json: MESSAGE_THEFT_DELETED
    end
    
      private
    
        def theft_params
            json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
            json_params.require(:theft).permit(:description, :time, :longitude, :latitude, tags: [:name])
        end
    
        # checking if a position was provided in the body parameters
        def position_provided?
            if theft_params[:longitude].blank? || theft_params[:latitude].blank?
                render json: ERROR_NO_POSITION
                return false
            else
                return true
            end
        end
        
        def valid_position_provided?
            10.times {puts theft_params[:longitude]}
            if is_float?(theft_params[:longitude]) &&
               is_float?(theft_params[:latitude])
                return true
            else
                render json: ERROR_POSITION_NOT_VALID
                return false
            end
        end

        def is_float? string
           true if Float(string) rescue false 
        end

        def resource_not_found
            render json: RESOURCE_NOT_FOUND
        end

end
