class Api::V1::ClientsController < Api::V1::ApiController
 
  def index
    if client_token?
      access = Doorkeeper::AccessGrant.where(application_id: doorkeeper_token.application_id)
      respond_with :api, :v1, User.where(id: access.ids)
    else
      render json: {error: "Blah" }.to_json, status: :not_found
    end
  end
end
