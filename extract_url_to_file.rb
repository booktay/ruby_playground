require 'open-uri'
require "nokogiri"

urls = []

image_urls = []

urls.each do |url|
    puts url

    # Get Source html from url
    doc = Nokogiri::HTML(open(url))

    # Get img urls list
    search_keyword = 'div.display_content img'
    filter_keyword = 'src'

    # Map URLs
    src_value = doc.css(search_keyword).map { |link| link[filter_keyword] }
    image_urls = image_urls + src_value
end

dest = "result/" + "url.json"
File.open(dest, 'wb') { |f| f.write(image_urls) }