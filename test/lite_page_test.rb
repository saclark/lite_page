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
  end
end
