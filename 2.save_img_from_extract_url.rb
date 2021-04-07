require 'open-uri'
require "nokogiri"
require 'fileutils'

urls = [
  "",
]


directory = "brt"
destination_path = "result/" + directory + "/"
unless File.directory?(destination_path)
  FileUtils.mkdir_p(destination_path)
end

images_quantity = 0

# Get img urls list
search_keyword = 'div#image-container img'
filter_keyword = 'src'

urls.each_with_index do |url, ep|
    puts "Start : " + url

    # Get Source html from url
    doc = Nokogiri::HTML(URI.open(url))

    # Map URLs
    image_urls = doc.css(search_keyword).map { |link| link[filter_keyword] }
    
    puts "%03d Number of images : %03d" % [(ep+1), image_urls.length]

    episode = url.split('/').last.tr('^0-9', '')
  
    # Save Results Url to file
    image_urls.each_with_index do |imgurl, index|
      name = "%s_%03d_%03d_%03d.jpg" % [directory, episode, (index+1), image_urls.length]

      URI.open(imgurl) do |u|
        File.open(destination_path + name, 'wb') { |f| f.write(u.read) }
      end

      if (index + 1) == 1 or (index + 1) == image_urls.length or (index + 1) % 5 == 0
        puts "[%03d/%03d] %s" % [(index+1), image_urls.length, name]
      end
    end
    puts "Complete : " + url
    images_quantity += image_urls.length
end
puts "Complete : Download %d images to %s/" % [images_quantity, directory] 

