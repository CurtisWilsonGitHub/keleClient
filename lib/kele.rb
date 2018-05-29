require "httparty"

class Kele
  include HTTParty
  base_uri 'www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post( "/sessions", body: {email: email, password: password})
    puts response.code
    @auth_token = response["auth_token"]
    if @auth_token.nil?
      raise "Invalid crednetials, please try again"
    end
  end
end
