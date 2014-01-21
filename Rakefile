def tagify_string(s)
  require "active_support/all"
  s.gsub(/&amp;|&|'/, '').parameterize
end

desc "Clear out _site dir"
task :clear do
  puts "Clearing out existing _site files..."
  sh "rm -rf _site/"
end

desc "Build the site before deployment"
task :build do
  puts "Building the site..."
  task("clear").invoke
  sh "bundle exec jekyll -t build"
end

desc "Serve the site locally"
task :serve do
  puts "Building the site..."
  task("clear").invoke
  sh "bundle exec jekyll -w -t serve"
end

desc "Start a new post from the base template"
task :new do
  require "date"
  require "fileutils"
  require "active_support/all"

  title = ENV["title"] || "Post title"
  date = ENV["date"] ? Time.parse("#{ENV["date"]} 9:00") : Time.now

  year = date.year
  month = date.strftime("%m")
  day = date.strftime("%d")
  titleparts = title.split(" ")
  filename = "#{year}-#{month}-#{day}-#{tagify_string(title)}.markdown"
  filepath = File.join(File.dirname(__FILE__), "_posts", year.to_s, month.to_s)
  mkdir_p(filepath) unless File.directory?(filepath)

  template = File.join(File.dirname(__FILE__), "_drafts", "base.markdown")
  new_post = File.read(template)
  new_post.gsub!("TITLE", title)
  new_post.gsub!("DATE", date.xmlschema)

  File.open(File.join(filepath, filename), "w") do |f|
    f.write new_post
  end
  puts "Done."
end
