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
    trending_courses = []
    getHtml.css(".trending-topics--topic--2pYSR").each do |course|
        name = course.css('.trending-topics--link--1B3Cq').map { |name| name.text.strip }
        stusents_count = course.css('.trending-topics--count--zZ-EO').map { |stusents_count| stusents_count.text.strip }
    
        trending_courses.push(
            name: name.first,
            stusents_count:stusents_count.first
        )
    end
    puts trending_courses
  end
end

reader = UdemyParser.new(uri)
reader.parse

