require "selenium-webdriver"

Selenium::WebDriver::Chrome::Service.driver_path="./chromedriver"
driver = Selenium::WebDriver.for :chrome

urls = [

]

video_urls = []



urls.each do |url|
    puts url

    driver.navigate.to url

    driver.switch_to.frame driver.find_element(:class, 'metaframe')
    element = driver.find_element(:class, 'jw-video')
    src = element.attribute('src')
    puts src
    video_urls.push(src)

    driver.execute_script("window.open()")
    driver.switch_to.window( driver.window_handles.last )
end

driver.quit
dest = "result/" + "url.json"
File.open(dest, 'wb') { |f| f.write(video_urls) }
