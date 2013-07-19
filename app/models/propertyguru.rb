class PropertyGuru < Property
  def class
    Property
  end
  
  def self.new_by_item(agent, main_page, item)
    p = self.new
    p.sitename = "PropertyGuru"
    link = Mechanize::Page::Link.new(item.at(".bluelink:nth-child(2)"), agent, main_page)
    price_string = to_string(item.at(".font14"))
    p.price = string_to_number(price_string)
    p.display_price = display_price(price_string, p.price)
    p.phone = item.at(".top2 .orangebold").text
    page2 = link.click
    p.link = page2.uri.to_s
    p.bedroom = string_to_number(to_string(page2.at(".bedroom")))
    p.bathroom = string_to_number(to_string(page2.at(".bathroom")))
    p.size = string_to_number(to_string(page2.at(".info1 p:nth-child(3)")))
  end
end