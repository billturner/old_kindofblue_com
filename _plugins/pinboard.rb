#
# Pinboard tag plugin for Jekyll
#
# Generates a list of links to a user's public Pinboard bookmarks.
#
# Usage:
#
#   {% pinboard user:username limit:# tags:tag,tag %}
#
# Example:
#
#   {% pinboard user:ericdfields limit:15 tags:ruby,rails %}
#
# All paramaters are optional, e.g.:
#
#   {% pinboard user:ericdfields %}
#
# The only parameters you can pass with the tag are: `user`, `limit`, and `tags`.
#
# Configuration options available for use in `_config.yml`:
#
#   pinboard_tag:
#     user:       "ericdfields"
#     limit:      15
#     tags:       "ruby,jekyll"
#     list_tag:   "ol"
#     list_class: "pinboard-list"
#     new_tab:    false
#     show_desc:  true
#
# ORIGINAL AUTHOR INFO:
#
# Eric D. Fields
# http://github.com/ericdfields/Jekyll_Pinboard_Tag
#
# UPDATES BY:
#
# Bill Turner
# http://github.com/billturner/jekyll-pinboard-tag
#

require 'net/http'
require 'json'

module Jekyll
  class PinboardTag < Liquid::Tag
    def initialize(tag_name, options, token)
      super

      @options = tag_options(options)
      @config = Jekyll.configuration({})['pinboard_tag'] || {}

      @user  = @options["user"]   || @config["user"]  || "ericdfields"
      @limit = (@options["limit"] || @config["limit"] || 15).to_i
      @tags  = @options["tags"]   || @config["tags"]  || nil

      @config["list_tag"]   ||= "ol"
      @config["list_class"] ||= "pinboard-list"
      @config["new_tab"]    ||= false
      @config["show_desc"]  ||= false
    end

    def render(context)
      <<-EOF
      <#{@config['list_tag']} class="#{@config['list_class']}">
        #{bookmarks.collect{ |bookmark| render_bookmark(bookmark) }.join}
      </#{@config['list_tag']}>
      EOF
    end

    def render_bookmark(bookmark)
      html  = "<li>"
      html += "<p><a href=\"#{bookmark.url}\""
      html += " target=\"_blank\"" if @config["new_tab"]
      html += ">"
      html += "#{bookmark.title}</a></p>"
      if @config["show_desc"] && bookmark.description != ""
        html += "<blockquote>#{bookmark.description}</blockquote>"
      end
      html += "</li>"
      html
    end

    def bookmarks
      @bookmarks = JSON.parse(json).map do |item|
        Bookmark.new(
          url:          item["u"],
          title:        item["d"],
          description:  item["n"],
          datetime:     item["dt"],
          author:       item["a"],
          tags:         item["t"]
        )
      end
    end

    def json
      url = "http://feeds.pinboard.in/json/v1/u:#{@user}/"
      unless @tags.nil?
        url += @tags.split(",").map{ |t| "t:#{t}" }.join("/")
        url += "/"
      end
      url += "?count=#{@limit}"
      response = Net::HTTP.get_response(URI.parse(url))
      return response.body
    end

    private

    def tag_options(options)
      clean_options = {}
      options = options.strip
      options.split.each do |o|
        next unless o =~ /:/
        option = o.split(":")
        next unless ["user", "limit", "tags"].include?(option[0])
        next unless option[1]
        clean_options[option[0]] = option[1]
      end
      clean_options
    end
  end

  class Bookmark
    attr_reader :url, :title, :description, :datetime, :author, :tags

    def initialize(params = {})
      @url          = params[:url]
      @title        = params[:title]
      @description  = params[:description]
      @datetime     = params[:datetime]
      @author       = params[:author]
      @tags         = params[:tags]
    end
  end
end

Liquid::Template.register_tag('pinboard', Jekyll::PinboardTag)
