module Jekyll
  class TagListTag < Liquid::Tag
    safe = true

    def initialize(name, params, tokens)
      super
    end

    def render(context)
      all_tags = context.registers[:site].tags.map{ |t,p| t }
      tag_html = []
      all_tags.sort.each do |tag|
        tag_html << "<a href=\"/tag/#{tag.downcase.gsub("\s", "-")}/\" rel=\"tag\">##{tag}</a>"
      end
      return tag_html.join(" \n")
    end
  end
end

Liquid::Template.register_tag('tag_list', Jekyll::TagListTag)
