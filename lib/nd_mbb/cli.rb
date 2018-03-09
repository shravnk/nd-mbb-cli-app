require_relative '../../config/environment'
require_relative '../nd_mbb'
require_relative '../nd_mbb/player'
require_relative '../nd_mbb/scraper'
require_relative '../nd_mbb/team'

class NdMbb::CLI

	attr_accessor :cur_team

	def welcome
		NdMbb::Scraper.make_players

		# NdMbb::Player.all.each {|p| p.add_attributes}
		# NdMbb::Player.all.each {|p| p.pull_stats}

		@cur_team = NdMbb::Team.new

		main_menu
	end

	def main_menu
		puts "\nNotre Dame Men's Basketball -- Main Menu\n"
		puts "1. Team Information\n2. Player Information\n3. Exit Application\n\nEnter a number to select an option:"
		option = gets.strip
		puts "\n"
		case option
		when "1"
			self.team_nav
		when "2"
			self.get_player
		when "3"
			exit
		else
			puts "Please select an option 1-3"
			main_menu
		end
	end

	def get_player
				
		NdMbb::Player.all.each_with_index do |p,i|
			puts "#{i+1}. #{p.name}"
		end

		puts "\nEnter a number to learn more about a player:"

		input = gets.strip.to_i - 1

		cur_player = NdMbb::Player.all[input]
		self.player_nav(cur_player)
	end

	def display_bio(cur_player)

		puts "\n#{cur_player.name}\n\n" +
		"Class: #{cur_player.class}\n" +
		"Hometown: #{cur_player.hometown}\n"+
		"High School: #{cur_player.high_school}\n" +
		"Height: #{cur_player.height}\n" +
		"Weight: #{cur_player.weight}\n" +
		"Position: #{cur_player.position}\n"

		self.player_nav(cur_player)
	end

	def display_stats(cur_player)
		if !cur_player.seasons.empty?
			cur_player.seasons.each_with_index{|seas, i| puts "#{i+1}. #{seas[:year]}"}
			puts "Enter a number to select a season:"
			s_ind = gets.strip.to_i - 1

			puts "\n#{cur_player.seasons[s_ind][:year]}\n\n" +
			"Games Played: #{cur_player.seasons[s_ind][:games_played]}\n" +
			"Minutes: #{cur_player.seasons[s_ind][:minutes]}\n" +
			"Points: #{cur_player.seasons[s_ind][:points]}\n" +
			"Points Avg: #{cur_player.seasons[s_ind][:avgpoints]}\n" +
			"FG Pct: #{cur_player.seasons[s_ind][:fieldgoalpct]}\n" +
			"3 Pt FG Pct: #{cur_player.seasons[s_ind][:fieldgoalpct3p]}\n" +
			"Assists: #{cur_player.seasons[s_ind][:assists]}\n" +
			"Turnovers: #{cur_player.seasons[s_ind][:turnovers]}\n" +
			"Blocks: #{cur_player.seasons[s_ind][:blocks]}\n" +
			"Steals: #{cur_player.seasons[s_ind][:steals]}\n\n"
		else
			puts "There are no stats available for this player.\n\n"
		end

		self.player_nav(cur_player)
	end

	def player_nav(cur_player)
		puts "\n#{cur_player.name} -- Menu"
		puts "1. View player bio\n2. View player stats\n3. View Another Player\n4. Main Menu\n5. Exit Application\n\nEnter a number to select an option:"
		option = gets.strip
		puts "\n"
		case option
		when "1"
			self.display_bio(cur_player)
		when "2"
			self.display_stats(cur_player)
		when "3"
			self.get_player
		when "4"
			self.main_menu
		when "5"
			exit
		else
			puts "Please select an option 1-5"
			player_nav(cur_player)
		end
	end	

	def team_totals
		puts "\nNotre Dame Men's Basketball - 2017-2018 TEAM TOTALS\n"

		puts "Points: #{@cur_team.points}"
		# \nAssists: #{cur_team.assists}\nTurnovers: #{cur_team.turnovers}\nBlocks: #{cur_team.blocks}\nSteals: #{cur_team.steals}\n"

		self.team_nav
		
	end

	def team_leaders

	end

	def team_nav
		puts "\nNotre Dame Men's Basketball - 2017-18 -- Menu"
		puts "1. Team Totals\n2. Team Leaders\n3. Main Menu\n4. Exit Application\n\nEnter a number to select an option:"
		option = gets.strip
		puts "\n"
		case option
		when "1"
			self.team_totals
		when "2"
			self.team_leaders
		when "3"
			self.main_menu
		when "4"
			exit
		else
			puts "Please select an option 1-4"
			team_nav
		end
	end


end
