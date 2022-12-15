require 'open-uri'
require 'nokogiri'
require_relative 'trending_course'
require_relative '../saving_utils.rb'

uri = 'https://www.udemy.com/'

class TrandingCoursesParser

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
      topic = course.css('.trending-topics--link--1B3Cq').map { |a| a['href'].strip }.to_s()
      course_model = TrandingCourse.new(name.first, stusents_count.first.chomp(' students'), topic.tr('["/topic/', '').tr('/"]', ''))
      course_model.display_details()
      trending_courses.push(course_model.get_json_object())
    end

    save_file(trending_courses)
  end

  def save_file(items)
    storag_service = StorageService.new
    storag_service.save_csv(File.join(File.dirname(__FILE__), 'trending_courses.csv'), items, ['name', 'stusents_count, topic'])
    storag_service.save_json(File.join(File.dirname(__FILE__), 'trending_courses.json'), items)
  end
end

reader = TrandingCoursesParser.new(uri)
reader.parse

