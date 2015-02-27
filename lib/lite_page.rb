require 'uri'
require 'watir-webdriver'
require 'lite_page/version'
require 'lite_page/page_initializers'
require 'lite_page/element_factory'

module LitePage
  # Extends the including class with the ElementFactory and ClassMethods modules.
  def self.included(base)
    base.extend(ElementFactory)
    base.extend(ClassMethods)
  end

  # Initializes the page instance and sets the browser instance
  #
  # @param browser [Object] the browser instance
  # @return [Object] the browser instance
  def initialize(browser)
    @browser = browser
  end

  module ClassMethods
    # Defines an instance method :page_url which returns the url passed to this
    # method and takes optional query parameters that will be appended to the
    # url if given.
    #
    # @param url [String] the page url
    # @return [Symbol] the name of the defined method (ruby 2.1+)
    def page_url(url)
      define_method(:page_url) do |query_params = {}|
        uri = URI(url)
        existing_params = URI.decode_www_form(uri.query || '')
        new_params = query_params.to_a

        unless existing_params.empty? && new_params.empty?
          combined_params = existing_params.push(*new_params)
          uri.query = URI.encode_www_form(combined_params)
        end

        uri.to_s
      end
    end
  end
end
