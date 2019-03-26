# frozen_string_literal: true

module Clerk
  module Testing
    # https://github.com/rails/rails/blob/a429b29425027006f2bbd4d267928dde1dc2c31a/activesupport/lib/active_support/testing/declarative.rb
    module Declarative
      unless defined?(Spec)
        def test(name, &block)
          test_name = "test_#{name.gsub(/\s+/, '_')}".to_sym
          defined = method_defined? test_name

          raise "#{test_name} is already defined in #{self}" if defined

          if block_given?
            define_method(test_name, &block)
          else
            define_method(test_name) do
              flunk "No implementation provided for #{name}"
            end
          end
        end
      end
    end
  end
end
