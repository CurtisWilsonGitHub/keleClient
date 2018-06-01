require 'httparty'
require 'json'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'
  attr_reader :me

  def initialize(email, password)
    response = self.class.post( "/sessions", body: {"email": email, "password": password})
    @auth_token = response["auth_token"]
    if @auth_token.nil?
      raise "Invalid crednetials, please try again"
    end
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
    @me = response
  end
  #
  # def get_mentor_availability
  #   mentor_id = @me['current_enrollment']['mentor_id']
  #   response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token})
  #   avail_array = JSON.parse(response.body)
  #   puts avail_array
  # end

end
