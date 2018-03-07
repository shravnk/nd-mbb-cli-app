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
		i = 1
		NdMbb::Player.all.each do |p|
			puts "#{i}. #{p.name}"
			i += 1
		end
	end
end
