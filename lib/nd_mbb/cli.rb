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
		if input.between?(0,NdMbb::Player.all.length - 1)
			self.player_nav(cur_player)
		else
			get_player
		end
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
			"Rebounds: #{cur_player.seasons[s_ind][:rebounds]}\n" +
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
		puts "\nNotre Dame Men's Basketball -- 2017-2018 -- Team Totals\n"
		c = @cur_team
		puts "Points: #{c.points}\nAssists: #{c.assists}\nRebounds: #{c.rebounds}\nTurnovers: #{c.turnovers}\nBlocks: #{c.blocks}\nSteals: #{c.steals}\n"

		self.team_nav
		
	end

	def leader_nav
		puts "\nNotre Dame Men's Basketball -- 2017-18 -- Team Leaders\n"
		puts "1. Points\n2. Assists\n3. Rebounds\n4. Turnovers\n5. Steals\n6. Blocks\n\nEnter a number to select an option:"
		option = gets.strip
		puts "\n"
		case option
		when "1"
			self.display_leaders("Points")
		when "2"
			self.display_leaders("Assists")
		when "3"
			self.display_leaders("Rebounds")
		when "4"
			self.display_leaders("Turnovers")
		when "5"
			self.display_leaders("Steals")
		when "6"
			self.display_leaders("Blocks")
		else
			puts "Please select an option 1-6"
			leader_nav
		end
	end

	def display_leaders(cat)
		puts "\nNotre Dame Men's Basketball -- 2017-18 -- #{cat} Leaders\n"
		c = @cur_team
		case cat
		when "Points"
			c.points_leaders.each_with_index{|player, i| puts "#{i+1}. #{player[:name]}:  #{player[:points]}"}
		when "Assists"
			c.assists_leaders.each_with_index{|player, i| puts "#{i+1}. #{player[:name]}:  #{player[:assists]}"}
		when "Turnovers"
			c.turnovers_leaders.each_with_index{|player, i| puts "#{i+1}. #{player[:name]}:  #{player[:turnovers]}"}
		when "Steals"
			c.steals_leaders.each_with_index{|player, i| puts "#{i+1}. #{player[:name]}:  #{player[:steals]}"}
		when "Blocks"
			c.blocks_leaders.each_with_index{|player, i| puts "#{i+1}. #{player[:name]}:  #{player[:blocks]}"}
		when "Rebounds"
			c.rebounds_leaders.each_with_index{|player, i| puts "#{i+1}. #{player[:name]}:  #{player[:rebounds]}"}
		else
			puts "Please select an option 1-6"
			display_leaders(cat)
		end
		team_nav
	end


	def team_nav
		puts "\nNotre Dame Men's Basketball -- 2017-18 -- Menu"
		puts "1. Team Totals\n2. Team Leaders\n3. Main Menu\n4. Exit Application\n\nEnter a number to select an option:"
		option = gets.strip
		puts "\n"
		case option
		when "1"
			self.team_totals
		when "2"
			self.leader_nav
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
