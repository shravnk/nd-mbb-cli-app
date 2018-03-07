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

	def player_bio
		puts "Enter a number to learn more about a player"
		
		NdMbb::Player.all.each_with_index do |p,i|
			puts "#{i+1}. #{p.name}"
		end

		input = gets.strip.to_i - 1

		cur_player = NdMbb::Player.all[input]

		puts cur_player.name
		puts cur_player.height
		puts cur_player.weight

	end
end
