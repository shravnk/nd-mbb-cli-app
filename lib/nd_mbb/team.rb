require_relative '../../config/environment'
require_relative '../nd_mbb'
require_relative '../nd_mbb/scraper'
require_relative '../nd_mbb/player'
require 'pry'
require 'nokogiri'
require 'open-uri'

class NdMbb::Team

	attr_accessor :points, :steals, :blocks, :assists, :turnovers
	attr_accessor :leaders

	def initialize
		@points = 0
		@steals = 0
		@blocks = 0
		@assists = 0
		@turnovers = 0
		@leaders = []
	end

	def this_season(seasons)
		seasons.select{|season| season[:year] == "2017-18"}
	end

	def leader_stats
		i = 0 
		NdMbb::Player.all.each do |player|
			if !this_season(player.seasons).empty?
				player_season = self.this_season(player.seasons)

				leaders[i] = Hash.new

				leaders[i][:name]
				leaders[i][:points] = player_season[0][:points].to_i
				leaders[i][:assists] = player_season[0][:assists].to_i
				leaders[i][:turnovers] = player_season[0][:turnovers].to_i
				leaders[i][:steals] = player_season[0][:steals].to_i
				leaders[i][:blocks] = player_season[0][:blocks].to_i

				i += 1
			end
		end
	end

	def agg_stats
		NdMbb::Player.all.each do |player|
			if !this_season(player.seasons).empty?
				player_season = self.this_season(player.seasons)
				
				l_points += player_season[0][:points].to_i
				l_steals += player_season[0][:steals].to_i
				l_blocks += player_season[0][:blocks].to_i
				l_assists += player_season[0][:assists].to_i
				l_turnovers += player_season[0][:turnovers].to_i
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
