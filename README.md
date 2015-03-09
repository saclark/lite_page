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

## Usage
If you are using cucumber, include the page initialization helper methods in the cucumber World instance.
```ruby
World(LitePage::PageInitializers)
```

Include `LightPage` in your page objects, define a `page_url` (if you want to be able to use the `PageInitializers`), and define elements on the page.

Page elements are defined by calling a method corresponding to the appropriate element type and passing it the name by which you wish to access the element and the selectors used to locate it.
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

Visit and interact with your page objects.
```ruby
visit(LoginPage).log_in('afinch', 'pa55w0rd')
```

## Contributing

1. Fork it ( http://github.com/saclark/lite_page/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
