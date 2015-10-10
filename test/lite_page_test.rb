require_relative 'test_helper'

class LitePageTest < Minitest::Spec
  describe LitePage do
    let(:page) { Class.new { include LitePage } }


    describe '::included' do
      it 'should extend the class with ClassMethods' do
        page.is_a?(LitePage::ClassMethods).must_equal(true)
      end
    end

    describe '#initialize' do
      it 'should assign its argument to @browser' do
        page.new('browser').instance_variable_defined?(:@browser).must_equal(true)
        proc { page.new }.must_raise ArgumentError
      end
    end

    describe '::ClassMethods#page_url' do
      it 'should define a page url instance method' do
        page.page_url('http://www.example.com')
        page.new(nil).must_respond_to(:page_url)
      end
    end

    describe '#page_url' do
      it 'should return the url when no arguments passed' do
        page.page_url('http://www.example.com')
        page.new(nil).page_url.must_equal('http://www.example.com')

        page.page_url('http://www.example.com?')
        page.new(nil).page_url.must_equal('http://www.example.com?')

        page.page_url('http://www.example.com?foo=bar')
        page.new(nil).page_url.must_equal('http://www.example.com?foo=bar')
      end

      it 'should accept query string parameters as an array or hash' do
        page.page_url('http://www.example.com')
        page.new(nil).page_url(:foo => 'bar').must_equal('http://www.example.com?foo=bar')

        page.page_url('http://www.example.com')
        page.new(nil).page_url([[:foo, 'bar']]).must_equal('http://www.example.com?foo=bar')
      end

      it 'should create query string if none existed before' do
        page.page_url('http://www.example.com')
        page.new(nil).page_url(:foo => 'bar').must_equal('http://www.example.com?foo=bar')

        page.page_url('http://www.example.com')
        page.new(nil).page_url(:foo => 'bar', :baz => 'qux').must_equal('http://www.example.com?foo=bar&baz=qux')
      end

      it 'should append query string parameters if some existed before' do
        page.page_url('http://www.example.com?')
        page.new(nil).page_url(:foo => 'bar').must_equal('http://www.example.com?foo=bar')

        page.page_url('http://www.example.com?foo=bar')
        page.new(nil).page_url(:baz => 'qux').must_equal('http://www.example.com?foo=bar&baz=qux')

        page.page_url('http://www.example.com?foo=bar')
        page.new(nil).page_url(:foo => :bar).must_equal('http://www.example.com?foo=bar&foo=bar')

        page.page_url('http://www.example.com?foo=bar')
        page.new(nil).page_url(:baz => 'qux', :fizz => 'buzz').must_equal('http://www.example.com?foo=bar&baz=qux&fizz=buzz')
      end
    end

    describe '#def_elements' do
      let(:browser) do
        Class.new do
          def echo_args(*args)
            args
          end

          alias_method :button, :echo_args
          alias_method :div, :echo_args
        end
      end

      it 'should define getters for all of the given definitions' do
        page.def_elements(:@browser, {
          :foo => [:button, :id => 'foo-element'],
          :bar => [:div, :class => 'bar-element']
        })

        page.new(browser.new).foo.must_equal([:id => 'foo-element'])
        page.new(browser.new).bar.must_equal([:class => 'bar-element'])
      end

      it 'should define getters that accept additional selectors' do
        page.def_elements(:@browser, :foo => [:button, :id => 'foo-element'])
        result = page.new(browser.new).foo(:text => /blah/)
        result.must_equal([:id => 'foo-element', :text => /blah/])
      end
    end
  end
end
