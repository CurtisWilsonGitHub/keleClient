module Roadmap
  def get_roadmap(chain_Id)
    response = self.class.get("/roadmaps/#{chain_Id}", headers: {"authorization" => @auth_token})
    roadmap_array = JSON.parse(response.body)
    puts roadmap_array
  end

  def get_checkpoint(checkpoint_Id)
    response = self.class.get("/checkpoints/#{checkpoint_Id}", headers: {"authorization" => @auth_token})
    checkpoint_array = JSON.parse(response.body)
    puts checkpoint_array
  end
end
