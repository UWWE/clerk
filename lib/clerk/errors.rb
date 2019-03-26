# frozen_string_literal: true

module Clerk
  class ClerkError < StandardError
    def self.status_code(code)
      define_method(:status_code) { code }
      if (match = ClerkError.all_errors.find { |_k, v| v == code })
        error, _ = match
        raise ArgumentError,
          "Trying to register #{self} for status code #{code} but #{error} is already registered"
      end
      ClerkError.all_errors[self] = code
    end

    def self.all_errors
      @all_errors ||= {}
    end
  end

  class DotclerkNotFound < ClerkError; status_code(10); end
end
