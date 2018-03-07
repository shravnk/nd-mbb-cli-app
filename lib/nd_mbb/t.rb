require 'pry'

height = "6-11\u00BD"


t = height.gsub(/\\\\u00BD/,' 1/2')
a = height.encode('utf-8')

puts height
puts t 
puts a