class SearchController < ApplicationController
  require 'mechanize'

  def home
  end

  def search
    @properties ||= Array.new
    if @properties.empty?
      add_pg_properties
      add_ip_properties
      add_st_properties
    end
    @properties.sort! { |x,y| y.price.to_i <=> x.price.to_i }
  end

  private

  # add the property listings from Propertyguru
  def add_pg_properties
    url = "http://www.propertyguru.com.sg/simple-listing?listing_type=sale&property_type=N&property_id=#{pg_id(params[:name])}&distance=0.5&minprice=#{params[:min_price]}&maxprice=#{params[:max_price]}&minsize=#{params[:min_size]}&items_per_page=700"
    
    page1 = agent.get(url)
    page1.search(".listing_item").each do |item|
      p = Property.new
      p.sitename = "PropertyGuru"
      link = Mechanize::Page::Link.new(item.at(".bluelink:nth-child(2)"), agent, page1)
      price_string = to_string(item.at(".font14"))
      p.price = string_to_number(price_string)
      p.display_price = display_price(price_string, p.price)
      p.phone = item.at(".top2 .orangebold").text
      page2 = link.click
      p.link = page2.uri.to_s
      p.bedroom = string_to_number(to_string(page2.at(".bedroom")))
      p.bathroom = string_to_number(to_string(page2.at(".bathroom")))
      p.size = string_to_number(to_string(page2.at(".info1 p:nth-child(3)")))
      @properties << p
    end
  end

  # add the property listings from iProperty
  def add_ip_properties
    url = "http://www.iproperty.com.sg/property/searchresult.aspx?t=S&gpt=P&k=#{CGI.escape(params[:name])}&rmp=700&mp=#{params[:min_price]}&xp=#{params[:max_price]}&mbu=#{params[:min_size]}"
    page1 = agent.get(url)
    page1.search(".SGmiddleColsub").each do |item|
      p = Property.new
      p.sitename = "iProperty"
      price_string = to_string(item.at(".pricegreen"))
      p.price = string_to_number(price_string)
      p.display_price = display_price(price_string, p.price)
      p.bedroom = string_to_number(to_string(item.at("strong:nth-child(3)")))
      p.bathroom = string_to_number(to_string(item.at("strong:nth-child(5)")))
      p.phone = item.at("a.tooltip[href*='JavaScript']")[:onclick].split('\'')[-4]
      p.size = item.at(".sr_text").text.strip[/[0-9\.\,]+ sq\. ft\./][/[0-9\.\,]+/].split(',').join.to_i
      p.link = "http://www.iproperty.com.sg" + item.at(".sr_link:nth-child(4) a")[:href]
      @properties << p
    end
  end

  # add the property listings from STProperty
  def add_st_properties
    url = "http://www.stproperty.sg/property-for-sale/condo-for-sale/name/#{params[:name].gsub(' ', '-').downcase}/min-selling-price-#{params[:min_price]}/max-selling-price-#{params[:max_price]}/min-floor-#{params[:min_size]}/size-700"
    page1 = agent.get(url)
    page1.search(".sr-e-col-right").each do |item|
      p = Property.new
      p.sitename = "STProperty"
      price_string = to_string(item.at(".sr-e-datenameprice h3"))
      p.price = string_to_number(price_string)
      p.display_price = display_price(price_string, p.price)
      p.bedroom = string_to_number(to_string(item.at(".sr-e-bedbath li:nth-child(1) strong")))
      p.bathroom = string_to_number(to_string(item.at(".sr-e-bedbath li:nth-child(2) strong")))
      p.size = item.at(".sr-e-info li:nth-child(1) a").text.strip[/[0-9\.\,]+ sqft/][/[0-9\.\,]+/].split(',').join.to_i
      p.link = "http://www.stproperty.sg" + item.at("h2 a")[:href]
      sales_link = Mechanize::Page::Link.new(item.at(".sr-e-datenameprice a"), agent, page1)
      # page2 = sales_link.click
      # p.phone = ""
      @properties << p
    end
  end

  def to_string(node)
    node.text.strip unless node.nil?
  end

  def string_to_number(string)
    if string && string[/[0-9\.\,]+/]
      string[/[0-9\.\,]+/].split(',').join.to_i
    else
      nil
    end
  end

  def pg_id(string)
    Property::PG_IDS[Property::PROPERTY_NAMES.index(string)]
  end

  def display_price(string, number)
    if number.nil?
      string
    else
      number_to_currency(number, precision: 0, unit: "$ ")
    end
  end
  
  def agent
    @agent ||= Mechanize.new
  end
end
