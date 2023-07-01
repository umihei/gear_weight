require "test_helper"
require "capybara/rails"

# class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#   driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
# end

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :selenium_headless do |app|
      options = Selenium::WebDriver::Chrome::Options.new
    
      options.add_argument('--headless')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-gpu')
      options.add_argument('--disable-dev-shm-usage')
      options.add_argument('--window-size=1366,720')
      options.add_argument('--remote-debugging-port=9222')
      options.binary = '/usr/bin/chromium-browser'
    
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

    Capybara.default_driver = :selenium_headless

  driven_by :selenium_headless, using: :chrome, screen_size: [1400, 1400]
end