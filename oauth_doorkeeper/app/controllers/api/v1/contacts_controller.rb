class Api::V1::ContactsController < Api::V1::ApiController
  before_action :doorkeeper_authorize!

  def index
    respond_with :api, :v1, current_user.contacts
  end

  def create
    contact = current_user.contacts.new(permited_params)
    if contact.save
      respond_with :api, :v1, contact
    else
      respond_with :api, :v1, contact
    end
  end

  def show
    respond_with :api, :v1, current_user.contacts.find(params[:id])
  end

  def permited_params
    params.require(:contact).permit!
  end
end