# frozen_string_literal: true

require 'pathname'

module Clerk
  module Testing
    module Fixture
      FIXTURE_PATH = Pathname.new(File.expand_path('../support/fixtures', __dir__))

      def fixture(fixture_name)
        path = Pathname.new(File.join(FIXTURE_PATH, fixture_name))

        if path.exist?
          path
        else
          msg = "the directory '#{path}' does not contain a file named '#{fixture_name}'"
          raise ArgumentError, msg
        end
      end
    end
  end
end
