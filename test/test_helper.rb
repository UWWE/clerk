# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'clerk'

require 'minitest/autorun'

require 'active_support/testing/declarative'
require 'active_support/testing/time_helpers'
require 'active_support/testing/file_fixtures'

require 'webmock/minitest'

Dir["#{File.expand_path('support', __dir__)}/*.rb"].each do |file|
  require file
end

module Clerk
  class TestCase < ::Minitest::Test
    include Testing::Path
    include Testing::Fixture
    include ActiveSupport::Testing::TimeHelpers
    extend ActiveSupport::Testing::Declarative
  end
end
