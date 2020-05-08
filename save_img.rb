require 'open-uri'
require "nokogiri"

urls = []

# Save Results Url to file
urls.each_with_index do |url, index|
  puts url
  directory = "hacd"
  name = url.split('/').last
  dest = "result/" + directory + "/" + name

  open(url) do |u|
    File.open(dest, 'wb') { |f| f.write(u.read) }
  end
end
puts "Number of images : " + urls.length.to_s