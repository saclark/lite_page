module LitePage
  # Defines a set of class methods on the including class corresponding to
  # each of the instance methods available on the `Watir::Container` class.
  # Each class method takes a symbol or string that will be used to
  # dynamically define an instance method on the including class that takes
  # any number of arguments so long as they are valid arguments for the
  # corresponding `Watir::Container` instance method. When the instance method
  # is called, it will call the corresponding `Watir::Container` instance method
  # on the class instance's browser instance along with the parameters given
  # to the class method.
  module ElementFactory
    Watir::Container.instance_methods.each do |tag_name|
      define_method(tag_name) do |method_name, *args, &block|
        define_method(method_name) { @browser.send(tag_name, *args, &block) }
      end
    end
  end
end
