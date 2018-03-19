class NdMbb::Team

	attr_accessor :points, :steals, :blocks, :assists, :turnovers, :rebounds
	attr_accessor :leaders

	def initialize
		@points = 0
		@steals = 0
		@rebounds = 0
		@blocks = 0
		@assists = 0
		@turnovers = 0
		@leaders = []
		self.leader_stats
		self.agg_stats
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

				leaders[i][:name] = player_season[0][:name]
				leaders[i][:points] = player_season[0][:points].to_i
				leaders[i][:assists] = player_season[0][:assists].to_i
				leaders[i][:turnovers] = player_season[0][:turnovers].to_i
				leaders[i][:steals] = player_season[0][:steals].to_i
				leaders[i][:blocks] = player_season[0][:blocks].to_i
				leaders[i][:rebounds] = player_season[0][:rebounds].to_i

				i += 1
			end
		end
	end

	def agg_stats
		NdMbb::Player.all.each do |player|
			if !this_season(player.seasons).empty?
				player_season = self.this_season(player.seasons)

				self.points += player_season[0][:points].to_i
				self.steals += player_season[0][:steals].to_i
				self.blocks += player_season[0][:blocks].to_i
				self.assists += player_season[0][:assists].to_i
				self.turnovers += player_season[0][:turnovers].to_i
				self.rebounds += player_season[0][:rebounds].to_i
				# binding.pry
			end
		end
	end

	def sort_leaders(category)
		leaders.sort_by{|player| player[category.downcase.to_sym]}.reverse[0..4]
	end

end
