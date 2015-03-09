module LitePage
  module PageInitializers
    # Initializes an instance of the given page class, drives the given browser
    # instance to the page's url with any given query parameters appended,
    # yields the page instance to a block if given, and returns the page instance.
    #
    # @param page_class [Class] the page class
    # @param query_params [Hash, Array] the query parameters to append to the page url to viist
    # @param browser [Object] the browser instance
    # @yield [page] yields page instance to a block
    def visit(page_class, query_params = {}, browser = @browser)
      page = page_class.new(browser)

      url = query_params.empty? ? page.page_url : page.page_url(query_params)
      browser.goto(url)

      yield page if block_given?
      page
    end

    # Initializes and returns an instance of the given page class. Yields the
    # page instance to a block if given.
    #
    # @param page_class [Class] the page class
    # @param browser [Object] the browser instance
    # @yield [page] yields page instance to a block
    def on(page_class, browser = @browser)
      page = page_class.new(browser)
      yield page if block_given?
      page
    end
  end
end
