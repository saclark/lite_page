module LitePage
  module ElementFactory
    # Provides convenient method for concisely defining element getters
    #
    # @param root_elem_var_name [Symbol] the name of the instance variable
    #   containing the element on which methods should be caleld
    #   (typically the browser instance).
    # @param element_definitions [Hash] the hash used to define element getters
    #   on the class instance where each key represents the name of the method
    #   to be defined and whose value is an array containing first, the
    #   element tag name and second, the selectors with which to locate it.
    def def_elements(root_elem_var_name, element_definitions = {})
      element_definitions.each do |name, definition|
        define_method(name) do |other_selectors = {}|
          definition[1].merge!(other_selectors)
          instance_variable_get(root_elem_var_name.to_sym).send(*definition)
        end
      end
    end
  end
end
