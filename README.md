# LitePage

[![Gem Version](https://badge.fury.io/rb/lite_page.svg)](http://badge.fury.io/rb/lite_page) [![Build Status](https://travis-ci.org/saclark/lite_page.svg?branch=master)](https://travis-ci.org/saclark/lite_page) [![Coverage Status](https://coveralls.io/repos/saclark/lite_page/badge.svg)](https://coveralls.io/r/saclark/lite_page)

A gem providing a quick, clean, and concise means of implementing the Page Object Model pattern and defining a semantic DSL for automated acceptance tests using watir-webdriver.

## Installation

Add this line to your application's Gemfile:

    gem 'lite_page'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lite_page

## Documentation
You can find comprehensive [documentation in the wiki](https://github.com/saclark/lite_page/wiki)

### Example Usage

If using cucumber, include `LitePage::PageInitializers` in the `World` instance
```ruby
World(LitePage::PageInitializers)
```

Define a page object:
```ruby
class LoginPage
  include LitePage
  page_url('http://www.example.com/login')

  text_field(:username, :label => 'Username')
  text_field(:password, :label => 'Password')
  button(:log_in_button, :text => 'Log In')

  def log_in(username, password)
    self.username.set(username)
    self.password.set(password)
    self.log_in_button.click
  end
end
```

Interact with the page:
```ruby
visit(LoginPage).log_in('afinch', 'mockingbird60')
```

## Contributing

1. Fork it ( http://github.com/saclark/lite_page/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
