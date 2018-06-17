require 'httparty'
require 'json'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

  base_uri 'https://www.bloc.io/api/v1'
  attr_reader :me, :checkpointId

  def initialize(email, password)
    response = self.class.post( "/sessions", body: {"email": email, "password": password})
    @auth_token = response["auth_token"]
    if @auth_token.nil?
      raise "Invalid credentials, please try again"
    end
  end

  def get_me
    response = self.class.get("/users/me", headers: { "authorization" => @auth_token })
    @me = response
    get_me_array = JSON.parse(response.body)
    puts get_me_array
  end

  def get_mentor_availability
    mentor_id = @me['current_enrollment']['mentor_id']
    response = self.class.get("/mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token})
    avail_array = JSON.parse(response.body)
    puts avail_array
  end

  def get_messages(page = 0)
    if page > 0
      message_threads_url = "/message_threads/?page=#{page}"
    else
      message_threads_url = "/message_threads"
    end

    response = self.class.get(message_threads_url, headers: {"authorization" => @auth_token})
    puts response
  end

  def create_message(sender, recipient_id, subject, stripped_text)
    response = self.class.post("/messages", headers: {"authorization" => @auth_token}, body:{
      "sender": sender,
      "recipient_id": recipient_id,
      "subject": subject,
      "stripped-text": stripped_text
      })
      response.success? puts 'Message was sent!'
  end

  def get_remaining_checkpoints(chain_id)
    response = self.class.get("/checkpoints/#{chain_id}", headers: {"authorization" => @auth_token})
    checkpoint_array = JSON.parse(response.body)
    puts checkpoint_array
  end
end
