class NdMbb::Scraper

  def self.get_page
    Nokogiri::HTML(open("http://www.und.com/sports/m-baskbl/mtt/nd-m-baskbl-mtt.html"))
  end

  def self.make_players
    get_page.css("table#sortable_roster tr a").each do |player|
      p_name = player.text
      p_link = player['href']
      NdMbb::Player.new({name: p_name, link: p_link})
    end
  end

end



