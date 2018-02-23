require 'pry'
require 'nokogiri'
require 'open-uri'

b = '/sports/m-baskbl/mtt/dj_harvey_1047144.html'
page = Nokogiri::HTML(open("http://www.und.com" + b))


t = page.css("div#biotable-info font")[4].text.split(":")[1]

binding.pry
