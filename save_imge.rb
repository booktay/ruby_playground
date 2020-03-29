require 'open-uri'

def download_image(url, dest)
  puts url
  open(url) do |u|
    File.open(dest, 'wb') { |f| f.write(u.read) }
  end
end

urls = [
  'http://petsfans.com/wp-content/uploads/2014/11/edfsaf.jpg',
  'http://dailynewsdig.com/wp-content/uploads/2012/06/funny-cats.jpg',
]

prefix = "36"

urls.each_with_index { |url, index | download_image(url, "result/" + prefix + "_" + index.to_s + ".jpg") }
