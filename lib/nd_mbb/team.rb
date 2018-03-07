require_relative '../../config/environment'
require_relative '../nd_mbb'
require_relative '../nd_mbb/scraper'
require_relative '../nd_mbb/player'
require 'pry'
require 'nokogiri'
require 'open-uri'

class NdMbb::Team

	attr_accessor :points, :steals, :blocks

	def initialize
		@points = 0
		@steals = 0
		@blocks = 0
	end

	def this_season(seasons)
		seasons.select{|season| season[:year] == "2017-18"}
	end

	def agg_stats
		NdMbb::Player.all.each do |player|
			if !this_season(player.seasons).empty?
				player_season = self.this_season(player.seasons)
				puts player_season
				@points += player_season[0][:points].to_i
				@steals += player_season[0][:steals].to_i
				@blocks += player_season[0][:blocks].to_i
				# binding.pry
			end
		end
	end



	def pts_leaders #display top 5 pts leaders
	end

	def assts_leaders
	end

	def steals_leaders
	end


end
