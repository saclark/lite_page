require 'uri'
require 'lite_page/version'
require 'lite_page/page_initializers'

module LitePage
  # Extends the including class with the ElementFactory and ClassMethods modules.
  def self.included(base)
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
    # Defines an instance method `page_url` which returns the url passed to this
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

    # Provides convenient method for concisely defining element getters
    #
    # @param root_elem_var_name [Symbol] the name of the instance variable
    #   containing the element on which methods should be caleld
    #   (typically the browser instance).
    # @param element_definitions [Hash] the hash used to define element getters
    #   on the class instance where each key represents the name of the method
    #   to be defined and whose value is an array containing first, the
    #   element tag name and second, the selectors with which to locate it.
    def def_elements(root_elem_var_name, element_definitions = {})
      element_definitions.each do |name, definition|
        define_method(name) do |other_selectors = {}|
          definition[1].merge!(other_selectors)
          instance_variable_get(root_elem_var_name.to_sym).send(*definition)
        end
      end
    end
  end
end
