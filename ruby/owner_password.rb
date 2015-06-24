require 'rest-client'
require 'json'

class Api 
  AUTH_URL = 'http://localhost:3000/oauth/token'
  API_URL = 'http://localhost:3000/api/v1'

  def initialize(email, password)
    @email, @password = email, password
    @client_id = 'fdb0d9fd3980fd08c089b4d87f0e76fd755cda41becef9fba876c88a24d1bb12'
    @client_secret = '03c07d33526a54e7911f26cb251a7f60b167190f637f29593f0ec577fd880eb2'
  end

  def access_token
    @access_token ||= JSON.parse(request_token, symbolize_names: true)[:access_token]
  end  

  def request_token
    RestClient.post AUTH_URL, {
      grant_type: 'password',
      email: @email,
      password: @password,
      client_id: @client_id,
      client_secret: @client_secret
    }
    # aqui debe ir una logica en caso que el
    # server no responda el access_token, pero por ahora...
    
  end

  def get_all_contacts
    RestClient.get "#{API_URL}/contacts", 
                   {:Authorization => "Bearer #{access_token}"} do |response, request, result|
      response
    end
  end

  def sin_token_get_all_contacts
    RestClient.get "#{API_URL}/contacts" do |response, request, result|
      response
    end

  end

  def get_contact(id)
    RestClient.get "#{API_URL}/contacts/#{id}", 
                   {:Authorization => "Bearer #{access_token}"} do |response, request, result|
      response
    end
  end

  def create_contact(**params)
    RestClient.post "#{API_URL}/contacts", 
                    { contact: params },   
                    {:Authorization => "Bearer #{access_token}"} do |response, request, result|
      response
    end
  end
end
