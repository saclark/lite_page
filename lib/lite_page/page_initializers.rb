module LitePage
  module PageInitializers
    def visit(page_class, query_params = {}, browser = @browser)
      page = page_class.new(browser)

      url = query_params.empty? ? page.page_url : page.page_url(query_params)
      browser.goto(url)

      yield page if block_given?
      page
    end

    def on(page_class, browser = @browser)
      page = page_class.new(browser)
      yield page if block_given?
      page
    end
  end
end
