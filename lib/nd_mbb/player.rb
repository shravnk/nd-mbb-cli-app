require_relative '../../config/environment'
require_relative '../nd_mbb'
require_relative '../nd_mbb/scraper'
require 'pry'
require 'nokogiri'
require 'open-uri'

class NdMbb::Player
  @@all = []

  attr_accessor :name, :link, :class, :hometown, :high_school, :height, :weight, :position

  def initialize(player_hash)
    @name = player_hash[:name]
    @link = player_hash[:link]
    @@all << self
  end

  def self.all
    @@all
  end

  def add_attributes
    profile = Nokogiri::HTML(open('http://www.und.com' + self.link))
    self.class = profile.css("div#biotable-info font")[0].text.split(":")[1]
    self.hometown = profile.css("div#biotable-info font")[1].text.split(":")[1]
    self.high_school = profile.css("div#biotable-info font")[2].text.split(":")[1]
    self.height = profile.css("div#biotable-info font")[3].text.split(":")[1].split("/")[0]
    self.weight = profile.css("div#biotable-info font")[3].text.split(":")[1].split("/")[1]
    self.position = profile.css("div#biotable-info font")[4].text.split(":")[1]
  end
end
