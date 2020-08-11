require 'open-uri'
require "nokogiri"

urls = [
]

urls.each do |url|
    puts "Start : " + url

    # Get Source html from url
    doc = Nokogiri::HTML(open(url))

    # Get img urls list
    search_keyword = 'div#image-container img'
    filter_keyword = 'src'

    # Map URLs
    image_urls = doc.css(search_keyword).map { |link| link[filter_keyword] }
    
    puts "Number of images : " + image_urls.length.to_s

    # Save Results Url to file
    image_urls.each_with_index do |imgurl, index|
      directory = "opc"
      name = directory + "_" + url.split('/').last + "-" + (index+1).to_s + ".jpg"
      destination_path = "result/" + directory + "/" + name

      open(imgurl) do |u|
        File.open(destination_path, 'wb') { |f| f.write(u.read) }
      end

      puts (index+1).to_s + "/" + image_urls.length.to_s + "] " + name
    end
    puts "Complete : " + url
end


