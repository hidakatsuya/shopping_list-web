require 'capybara-playwright-driver'

Capybara.register_driver(:playwright) do |app|
  Capybara::Playwright::Driver.new(app,
    playwright_server_endpoint_url: ENV['PLAYWRIGHT_URL'],
    browser_type: :chromium,
    headless: true
  )
end
