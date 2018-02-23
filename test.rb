require 'pry'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://www.und.com/sports/m-baskbl/mtt/nd-m-baskbl-mtt.html"))


t = page.css("table#sortable_roster tr a")[0].text

binding.pry
