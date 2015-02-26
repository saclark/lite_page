require_relative 'test_helper'

class PageInitializersTest < Minitest::Spec
  describe LitePage::PageInitializers do
    let(:browser) do
      Class.new do
        attr_reader :location
        def goto(url)
          @location = url
        end
      end
    end

    let(:page) do
      Class.new do
        include LitePage
        page_url('http://www.example.com/page')
      end
    end

    let(:world) do
      Class.new do
        include LitePage::PageInitializers
        attr_accessor :browser
        def initialize(browser); @browser = browser; end
      end
    end

    before do
      @world = world.new(browser.new)
    end

    describe '#visit' do
      it 'should visit the page url' do
        @world.browser.location.must_be_nil
        @world.visit(page)
        @world.browser.location.must_equal('http://www.example.com/page')
      end

      it 'should visit the page url with any given query parameters' do
        @world.browser.location.must_be_nil
        @world.visit(page, :foo => 'bar')
        @world.browser.location.must_equal('http://www.example.com/page?foo=bar')
      end

      it 'should yeild an instance of the given page class to any given block' do
        @world.visit(page) { |page_instance| page_instance.must_be_instance_of page }
      end

      it 'should visit the page before yielding to a given block' do
        @world.browser.location.must_be_nil
        @world.visit(page) { |_| @world.browser.location.must_equal('http://www.example.com/page') }
        @world.browser.location.must_equal('http://www.example.com/page')
      end

      it 'should return an instance of the given page class' do
        @world.visit(page).must_be_instance_of page
      end

      it 'should accept a browser instance defaulting to @browser' do
        @world.visit(page, {}, browser.new)
        @world.visit(page).instance_variable_get(:@browser).must_be_same_as(@world.browser)
      end
    end

    describe '#on' do
      it 'should return an instance of the given page class' do
        @world.on(page).must_be_instance_of page
      end

      it 'should yeild an instance of the given page class to any given block' do
        @world.on(page) { |page_instance| page_instance.must_be_instance_of page }
      end

      it 'should accept an optional browser instance defaulting to @browser' do
        @world.on(page, browser.new)
        @world.on(page).instance_variable_get(:@browser).must_be_same_as(@world.browser)
      end
    end
  end
end
