require_relative './lib/WebAccount/VERSION'

Gem::Specification.new do |spec|
  spec.name = 'webaccount'

  spec.version = WebAccount::VERSION
  spec.date = '2020-04-19'

  spec.summary = "# Description: An abstract superclass for navigating a web-based user account via Selenium WebDriver."
  spec.description = "Easily log into web accounts but just supplying a username and password, the URL of the login page, and a few page ids to a subclass of WebAccount."

  spec.author = 'thoran'
  spec.email = 'code@thoran.com'
  spec.homepage = 'http://github.com/thoran/WebAccount'
  spec.license = 'Ruby'

  spec.files = Dir['lib/**/*.rb']
  spec.required_ruby_version = '>= 2.5'

  spec.add_dependency('selenium-webdriver')
end
