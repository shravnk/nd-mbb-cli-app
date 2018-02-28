require 'pry'
require 'nokogiri'
require 'open-uri'


# page = Nokogiri::XML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

# page = Nokogiri::HTML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

name = "GEBEN,MARTINAS"

def pull_player(n)
	page = Nokogiri::XML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

	# b = page.xpath("//player")[0].attributes
	# c = page.xpath("//player")[0].attribute('checkname').value
	# a = page.xpath(".//player[@checkname='#{n}']")[0].attribute("year")
	page.xpath("//player[@checkname='#{n}']/season").each do |season|
		puts season.attribute('year').value
	end

	# binding.pry


end




pull_player(name)





