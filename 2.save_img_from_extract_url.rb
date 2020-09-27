require 'open-uri'
require "nokogiri"
require 'fileutils'

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

    directory = "opc"
    episode = url.split('/').last.tr('^0-9', '')
    destination_path = "result/" + directory + "/"
    
    unless File.directory?(destination_path)
      FileUtils.mkdir_p(destination_path)
    end

    # Save Results Url to file
    image_urls.each_with_index do |imgurl, index|
      name = directory + "_" + episode + "_" + (index+1).to_s + ".jpg"

      open(imgurl) do |u|
        File.open(destination_path + name, 'wb') { |f| f.write(u.read) }
      end

      puts "[" + (index+1).to_s + "/" + image_urls.length.to_s + "] " + name
    end
    puts "Complete : " + url
end


