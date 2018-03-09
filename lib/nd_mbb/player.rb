require_relative '../../config/environment'
require_relative '../nd_mbb'
require_relative '../nd_mbb/scraper'
require_relative '../nd_mbb/team'
require 'pry'
require 'nokogiri'
require 'open-uri'

class NdMbb::Player
  @@all = []

  attr_accessor :name, :link, :class, :hometown, :high_school, :height, :weight, :position, :checkname
  attr_accessor :seasons

  def initialize(player_hash)
    @name = player_hash[:name]
    @link = player_hash[:link]
    @@all << self
    @seasons = []
    self.add_attributes
    self.pull_stats
  end

  def self.all
    @@all
  end

  def set_check
    profile = Nokogiri::HTML(open('http://www.und.com' + self.link))
    if profile.search('script').text.match(/thepliq = "(.+)"/)
      self.checkname = profile.search('script').text.match(/thepliq = "(.+)"/)[1]
    else
      self.checkname = nil
    end
  end

  def add_attributes
    profile = Nokogiri::HTML(open('http://www.und.com' + self.link))
    self.class = profile.css("div#biotable-info font")[0].text.split(":")[1]
    self.hometown = profile.css("div#biotable-info font")[1].text.split(":")[1]
    self.high_school = profile.css("div#biotable-info font")[2].text.split(":")[1]
    self.height = profile.css("div#biotable-info font")[3].text.split(":")[1].split("/")[0].strip
    self.weight = profile.css("div#biotable-info font")[3].text.split(":")[1].split("/")[1].strip
    self.position = profile.css("div#biotable-info font")[4].text.split(":")[1]
    set_check
   end

  def pull_stats
      page = Nokogiri::XML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))
      i = 0
      n = self.checkname
      page.xpath("//player[@checkname='#{n}']/season").each do |season|
        seasons[i] = Hash.new
                  
        seasons[i][:year] = season.attribute('year').value
        seasons[i][:games_played] = season.attribute('gp').value
        seasons[i][:minutes] = season.attribute('min').value
        seasons[i][:points] = season.attribute('tp').value
        seasons[i][:avgpoints] = season.attribute('ptsavg').value
        seasons[i][:fieldgoalpct] = season.attribute('fgpct').value
        seasons[i][:fieldgoalpct3p] = season.attribute('fg3pct').value
        seasons[i][:assists] = season.attribute('ast').value
        seasons[i][:turnovers] = season.attribute('to').value
        seasons[i][:blocks] = season.attribute('blk').value
        seasons[i][:steals] = season.attribute('stl').value

        seasons[i][:name] = self.name
        
        i += 1
      end

  end

end
