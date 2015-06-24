class Api::V1::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  skip_before_action :verify_authenticity_token

  respond_to :json

  def current_user
    p "doorkeeper_token ***********************************"
    p doorkeeper_token.inspect
    @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def set_current_application
    @current_application ||= Doorkeeper::Application.where( 
      uid: doorkeeper_token.application[:uid] 
    ) if doorkeeper_token
  end

  def client_token?
    doorkeeper_token.resource_owner_id.nil?
  end

  private
  def record_not_found(error)
    render :json => {:error => error.message}, :status => :not_found
  end 
end
