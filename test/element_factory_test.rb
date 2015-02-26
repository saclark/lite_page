require_relative 'test_helper'

class ElementFactoryTest < Minitest::Spec
  describe LitePage::ElementFactory do
    let(:page) do
      Class.new do
        extend LitePage::ElementFactory
        def initialize(browser)
          @browser = browser
        end
      end
    end

    let(:browser) do
      Class.new do
        def button(selectors)
          "button found using #{selectors.to_s}"
        end
      end
    end

    it 'should define class methods for each Watir::Container instance method' do
      Watir::Container.instance_methods.each do |method_name|
        page.must_respond_to method_name
      end
    end

    describe 'page elements defined' do
      it 'should create methods that call the appropriate method on the browser' do
        page.button(:my_button, :id => 'my-button')
        page.new(browser.new).my_button.must_equal('button found using {:id=>"my-button"}')
      end
    end
  end
end
