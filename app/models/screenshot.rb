# require 'capybara/rails'
require 'capybara/dsl'
require 'capybara/poltergeist'

class Screenshot
  extend Capybara::DSL

  def self.config
    Capybara.app_host = 'http://127.0.0.1:3000'
    Capybara.server_port = 3000
    Capybara.run_server = false
    Capybara.register_driver(:poltergeist) do |app|
      Capybara::Poltergeist::Driver.new(app, {
        :js_errors => false,
        :phantomjs_options => [
          '--ignore-ssl-errors=yes',
          '--ssl-protocol=any'
        ]
      })
    end
    Capybara.javascript_driver = :poltergeist
    Capybara.default_driver = :poltergeist
    Capybara.current_driver = :poltergeist
    page.driver.browser.url_whitelist = ['http://localhost:3000']
  end

  def self.capture(url)
    config
    visit url
    sleep(1)
    if page.status_code == 200
      page.driver.render_base64('jpg',
        :full => true,
        :quality => 100
      )
    end
  end
end



