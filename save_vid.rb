require 'open-uri'

urls = []

# Save Results Url to file
urls.each_with_index do |url, index|
  puts url
  directory = "ha4"
  name = "ha4" + (index+2).to_s
  dest = "result/" + directory + "/" + name

  open(url) do |u|
    File.open(dest, 'wb') { |f| f.write(u.read) }
  end
end
puts "Number of video : " + urls.length.to_s