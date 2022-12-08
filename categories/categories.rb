require 'open-uri'
require 'nokogiri'
require_relative '../saving_utils.rb'

uri = 'https://www.udemy.com/'


class UdemyParser
  def initialize(url)
    @url = url
  end

  def getHtml
    html = Nokogiri::HTML.parse(URI.open(@url), 'UTF-8')
    return html
  end

  def save_file(items)
    save = Save.new
    save.saveToCSV(File.join(File.dirname(__FILE__), 'categories.csv'), items, ['name'])
    save.saveToJSON(File.join(File.dirname(__FILE__), 'categories.json'), items)
  end

  def parse
    categories = []
    getHtml.css('.pill-group--pill--3z4Sb').each do |category|
      categories.push(
        name: category.at('span').text
       )
    end

    save_file(categories)

  end
end

reader = UdemyParser.new(uri)
reader.parse

