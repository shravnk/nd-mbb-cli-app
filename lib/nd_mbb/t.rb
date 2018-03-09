require_relative '../../config/environment'
require_relative '../nd_mbb'
require_relative '../nd_mbb/scraper'
require_relative '../nd_mbb/player'
require_relative '../nd_mbb/team'
require 'pry'
require 'nokogiri'
require 'open-uri'

NdMbb::Scraper.make_players

NdMbb::Player.all.each {|p| p.add_attributes}
NdMbb::Player.all.each {|p| p.pull_stats}

cur_team = NdMbb::Team.new


cur_team.agg_stats
cur_team.leader_stats

t = cur_team.points
a = cur_team.leaders[1]
b = cur_team.points_leaders

binding.pry

