module LitePage
  module ElementFactory
    Watir::Container.instance_methods.each do |tag_name|
      define_method(tag_name) do |method_name, *args, &block|
        define_method(method_name) { @browser.send(tag_name, *args, &block) }
      end
    end
  end
end
