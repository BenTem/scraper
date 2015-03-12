require 'rubygems'
require 'nokogiri'

class Post
  attr_reader :title, :url, :points, :item_id, :comments
  

  def initialize(title, url, points, item_id)
    @title = title
    @url = url
    @points = points
    @item_id = item_id
    @comments = []
  end

  def add_comment(comment)
    @comments << comment
  end
end



