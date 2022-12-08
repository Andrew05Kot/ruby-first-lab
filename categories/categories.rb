require 'open-uri'
require 'nokogiri'

uri = 'https://www.udemy.com/'


class UdemyParser
  def initialize(url)
    @url = url
  end

  def getHtml
    html = Nokogiri::HTML.parse(URI.open(@url), 'UTF-8')
    return html
  end

  def parse
    categories = []
    getHtml.css('.pill-group--pill--3z4Sb').each do |category|
      categories.push( category.at('span').text )
    end
    puts categories
  end
end

reader = UdemyParser.new(uri)
reader.parse

