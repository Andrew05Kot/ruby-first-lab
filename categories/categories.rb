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
    storag_service = StorageService.new
    storag_service.save_csv(File.join(File.dirname(__FILE__), 'categories.csv'), items, ['name'])
    storag_service.save_json(File.join(File.dirname(__FILE__), 'categories.json'), items)
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

