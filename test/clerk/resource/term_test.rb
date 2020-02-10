# frozen_string_literal: true

require 'test_helper'
require 'clerk/resource/term'

module Clerk
  module Resource
    class TermTest < Clerk::TestCase
      test '#code returns the correct term code' do
        assert_equal '1091', Term.new(2009, 2).code
        assert_equal '0999', Term.new(1999, 12).code
      end

      test '.today returns the correct term code' do
        travel_to Time.new(2018, 10, 24)
        assert_equal '1189', Term.today.code
      end

      test '.next_month returns the correct term code' do
        travel_to Time.new(2018, 8, 24)
        assert_equal '1189', Term.next_month.code

        travel_to Time.new(2018, 10, 24)
        assert_equal '1189', Term.next_month.code

        travel_to Time.new(2018, 12, 24)
        assert_equal '1191', Term.next_month.code
      end
    end
  end
end
