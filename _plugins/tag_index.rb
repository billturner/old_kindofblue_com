module Jekyll
  class TagIndex < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      tag_title_prefix = site.config['tag_title_prefix'] || "Posts tagged '"
      tag_title_suffix = site.config['tag_title_suffix'] || "'"
      self.data['title'] = "#{tag_title_prefix}#{tag.gsub("-", " ")}#{tag_title_suffix}"
      self.data['description'] = "All posts on the #{site.config['title']} weblog tagged with the term '#{tag.gsub("-", " ")}'."
    end
  end
  class TagGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'tag'
        dir = site.config['tag_dir'] || 'tag'
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, clean_tag_name(tag)), tag)
        end
      end
    end
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, clean_tag_name(tag))
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
    def clean_tag_name(t)
      t.gsub(" ", "-")
    end
  end
end
