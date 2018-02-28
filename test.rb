require 'pry'
require 'nokogiri'
require 'open-uri'


# page = Nokogiri::XML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

# page = Nokogiri::HTML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

name = "GEBEN,MARTINAS"

def pull_player(n)
	page = Nokogiri::XML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

	seasons = []
	i = 0 
	# b = page.xpath("//player")[0].attributes
	# c = page.xpath("//player")[0].attribute('checkname').value
	# a = page.xpath(".//player[@checkname='#{n}']")[0].attribute("year")
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

		i += 1
	end

	binding.pry


end




pull_player(name)





