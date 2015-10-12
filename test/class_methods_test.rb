require_relative 'test_helper'

class ClassMethodsTest < Minitest::Spec
  describe LitePage::ClassMethods do
    let(:page) { Class.new { extend LitePage::ClassMethods } }

    describe '::page_url' do
      it 'should define a page url instance method' do
        page.page_url('http://www.example.com')
        page.new.must_respond_to(:page_url)
      end
    end

    describe '#page_url' do
      it 'should return the url when no arguments passed' do
        page.page_url('http://www.example.com')
        page.new.page_url.must_equal('http://www.example.com')

        page.page_url('http://www.example.com?')
        page.new.page_url.must_equal('http://www.example.com?')

        page.page_url('http://www.example.com?foo=bar')
        page.new.page_url.must_equal('http://www.example.com?foo=bar')
      end

      it 'should accept query string parameters as an array or hash' do
        page.page_url('http://www.example.com')
        page.new.page_url(:foo => 'bar').must_equal('http://www.example.com?foo=bar')

        page.page_url('http://www.example.com')
        page.new.page_url([[:foo, 'bar']]).must_equal('http://www.example.com?foo=bar')
      end

      it 'should create query string if none existed before' do
        page.page_url('http://www.example.com')
        page.new.page_url(:foo => 'bar').must_equal('http://www.example.com?foo=bar')

        page.page_url('http://www.example.com')
        page.new.page_url(:foo => 'bar', :baz => 'qux').must_equal('http://www.example.com?foo=bar&baz=qux')
      end

      it 'should append query string parameters if some existed before' do
        page.page_url('http://www.example.com?')
        page.new.page_url(:foo => 'bar').must_equal('http://www.example.com?foo=bar')

        page.page_url('http://www.example.com?foo=bar')
        page.new.page_url(:baz => 'qux').must_equal('http://www.example.com?foo=bar&baz=qux')

        page.page_url('http://www.example.com?foo=bar')
        page.new.page_url(:foo => :bar).must_equal('http://www.example.com?foo=bar&foo=bar')

        page.page_url('http://www.example.com?foo=bar')
        page.new.page_url(:baz => 'qux', :fizz => 'buzz').must_equal('http://www.example.com?foo=bar&baz=qux&fizz=buzz')
      end
    end

    describe '#def_elements' do
      before do
        class Browser
          def echo_args(*args)
            args
          end

          alias_method :button, :echo_args
          alias_method :div, :echo_args
        end

        class Page
          extend LitePage::ClassMethods

          def initialize
            @my_browser = Browser.new
          end
        end
      end

      it 'should define getters for all of the given definitions' do
        Page.def_elements(:@my_browser, {
          :foo => [:button, :id => 'foo-element'],
          :bar => [:div, :class => 'bar-element']
        })

        Page.new.foo.must_equal([:id => 'foo-element'])
        Page.new.bar.must_equal([:class => 'bar-element'])
      end

      it 'should define getters that accept additional selectors' do
        Page.def_elements(:@my_browser, :foo => [:button, :id => 'foo-element'])
        result = Page.new.foo(:text => /blah/)
        result.must_equal([:id => 'foo-element', :text => /blah/])
      end
    end
  end
end
