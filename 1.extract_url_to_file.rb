require 'open-uri'
require "nokogiri"

urls = [
    "",
]

image_urls = []

urls.each do |url|
    puts url

    # Get Source html from url
    doc = Nokogiri::HTML(URI.open(url))

    # Get img urls list
    search_keyword = 'ul.lst a'
    filter_keyword = 'href'

    # Map URLs
    src_value = doc.css(search_keyword).map { |link| link[filter_keyword] }
    image_urls = image_urls + src_value
end

# puts image_urls
destination_path = "result/"
File.open(destination_path + "url.json", 'wb') { |f| f.write(image_urls.sort) }
