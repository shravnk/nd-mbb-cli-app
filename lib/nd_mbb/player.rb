require_relative '../../config/environment'

class NdMbb::Player
  @@all = []

  attr_accessor :name

  def initialize(player_hash)
    @name = player_hash[:name]
    @@all << self
  end

  def self.all
    @@all
  end
end
