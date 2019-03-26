# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'clerk'

require 'minitest/autorun'
require 'webmock/minitest'

Dir["#{File.expand_path('support', __dir__)}/*.rb"].each do |file|
  require file
end

module Clerk
  class TestCase < ::Minitest::Test
    extend Testing::Declarative
    include Testing::Path
  end
end
