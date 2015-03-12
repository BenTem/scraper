require 'rubygems'
require 'nokogiri'
require 'pp'
require 'open-uri'
require 'colorize'
require_relative 'post'
require_relative 'comment'



class Scraper

  input_url = ARGV[0]

  class URLError < StandardError  
  end

  raise URLError, 'Please use valid URL' unless input_url =~ /\A#{URI::regexp}\z/


  @doc = Nokogiri::HTML(open(input_url)) 

  def self.create_post
   points = @doc.search('.subtext > span:first-child').map { |span| span.inner_text}
   item_id = @doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }
   title = @doc.search('.title > a').map { |link| link.inner_text}
   url = @doc.search('.title > a').map { |link| link['href']}

   Post.new(title, url, points, item_id)


  end

  def self.add_comments(post)
    user_names = @doc.search('.comhead > a:first-child').map { |font| font.inner_text} 
    comments = @doc.search('.comment > font:first-child').map { |font| font.inner_text} 
    i = 0
    while i < comments.length
      post.add_comment(Comment.new(user_names[i], comments[i]))
      i += 1
    end
  end
end

post = Scraper.create_post
Scraper.add_comments(post)
puts "title: #{post.title}".colorize(:yellow)
puts "comments: #{post.comments.length}".colorize(:red)
puts "points: #{post.points}".green
