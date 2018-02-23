class NdMbb::Scraper

  def get_page
    Nokogiri::HTML(open("http://www.und.com/sports/m-baskbl/mtt/nd-m-baskbl-mtt.html"))
  end

  def make_players
    player_array = []
    self.get_page.css("table#sortable_roster tr a").each do |player|
      p_name = player.text
      binding.pry
      player_array << {name: p_name}
    end
  end

end

make_players
