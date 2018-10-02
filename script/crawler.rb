#!/usr/bin/env ruby

require File.expand_path('../../config/environment', __FILE__)

require 'pry'
require 'nokogiri'
require 'open-uri'
require 'awesome_print'


links = []
tags = []
# Fetch and parse HTML document
doc = Nokogiri::HTML(open('https://www.imdb.com/search/title?groups=top_250&sort=user_rating'))
links = doc.css('.lister-item')

Movie_Info = Struct.new(:title, :runtime, :rating, :image_url, :genre)

links.each do |item|

# header
  header = item.css('h3.lister-item-header > a').text

  # info
  genre_all = item.css("p.text-muted > span.genre").text
  genre = genre_all.split(",").map { |i| i.gsub("\n", '') }

  # runtime
  runtime = item.css("p.text-muted > span.runtime").text
  cert = item.css("p.text-muted > span.certificate").text

  # image
  images = item.at_css("img").attr("loadlate")

  film = Movie_Info.new(header, runtime, cert, images, genre)
  tags << film

end

while tags.count > 0


# create a movie
  tags.each do |tag|
    my_movie = Movie.find_or_create_by(title: tag.title)
    my_movie.update(duration: tag.runtime, rating: tag.rating, image: tag.image_url)

     tag.genre.each do |t|

      # tags
      my_tags = Tag.find_or_create_by(name: t.strip)
      my_movie.tags.find_or_create_by(name: t.strip)
    end
  end

  tags.shift
end
