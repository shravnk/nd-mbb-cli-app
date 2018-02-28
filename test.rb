require 'pry'
require 'nokogiri'
require 'open-uri'


# page = Nokogiri::XML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

page = Nokogiri::HTML(open('http://www.und.com/sports/m-baskbl/stats/2017-2018/indiv.xml'))

name = "GEBEN,MARTINAS"



# b = page.xpath("//player")[0].attributes
# c = page.xpath("//player")[0].attribute('name').value
# a = page.xpath("//player/season")
#
# a = page.xpath("//player")
#
# a.each do |player|
#   puts player.xpath("//season/*[2014-15]")
# end

binding.pry


