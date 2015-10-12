require_relative 'test_helper'

class ElementFactoryTest < Minitest::Spec
  describe LitePage::ElementFactory do
    before do
      class Browser
        def echo_args(*args)
          args
        end

        alias_method :button, :echo_args
        alias_method :div, :echo_args
      end

      class Page
        extend LitePage::ElementFactory

        def initialize
          @my_browser = Browser.new
        end
      end
    end

    describe '#def_elements' do
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
