require 'uri'
require 'watir-webdriver'
require 'lite_page/version'
require 'lite_page/page_initializers'
require 'lite_page/element_factory'

module LitePage
  def self.included(base)
    base.extend(ElementFactory)
    base.extend(ClassMethods)
  end

  def initialize(browser)
    @browser = browser
  end

  module ClassMethods
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
