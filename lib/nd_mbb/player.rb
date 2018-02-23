class NdMbb::Player
  attr_accessor :name
  def initialize(player_hash)
    @name = player_hash[:name]
  end
end
