require_relative '../../config/environment'
require_relative '../nd_mbb'
require_relative '../nd_mbb/player'
require_relative '../nd_mbb/scraper'

class NdMbb::CLI
	def welcome
		NdMbb::Scraper.make_players

		NdMbb::Player.all.each {|p| p.add_attributes}
		NdMbb::Player.all.each {|p| p.pull_stats}

		puts "Welcome to the home of Notre Dame Men's Basketball!"
		player_bio
	end

	def display_stats(cur_player)
		cur_player.seasons.each_with_index{|seas, i| puts "#{i+1}. #{seas[:year]}"}
		puts "Enter a number to select a season:"
		s_ind = gets.strip.to_i - 1

		puts "\n#{cur_player.seasons[s_ind][:year]}\n\n" +
		"Games Played: #{cur_player.seasons[s_ind][:games_played]}" +
		"Minutes: #{cur_player.seasons[s_ind][:minutes]}" +
		"Points: #{cur_player.seasons[s_ind][:points]}"
	end

	def player_bio
				
		NdMbb::Player.all.each_with_index do |p,i|
			puts "#{i+1}. #{p.name}"
		end

		puts "\nEnter a number to learn more about a player:"

		input = gets.strip.to_i - 1

		cur_player = NdMbb::Player.all[input]

		puts "\n#{cur_player.name}\n\n" +
		"Class: #{cur_player.class}\n" +
		"Hometown: #{cur_player.hometown}\n"+
		"High School: #{cur_player.high_school}\n" +
		"Height: #{cur_player.height}\n" +
		"Weight: #{cur_player.weight}\n" +
		"Position: #{cur_player.position}\n\n"

		puts "Would you like to see this player's stats? (y/n)"
		ans = gets.strip

		if ans.upcase == "Y"
			display_stats(cur_player)
		else
			puts "Would you like to see another player?"
			another = gets.strip
			if another.upcase == "Y"
				player_bio
			else
				exit
			end
		end



	end
end
