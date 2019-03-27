# frozen_string_literal: true

require 'test_helper'
require 'clerk/resource/subject'
require 'clerk/resource/subject_schedule'

module Clerk
  module Resource
    class SubjectScheduleTest < Clerk::TestCase
      def setup
        @settings = Clerk::Settings.new(app('.clerk'))
        @settings.set_local('uw_api_key', 'secret')
      end

      test '#download downloads raw JSON data from the API' do
        stub_request(:get, 'https://api.uwaterloo.ca/v2/terms/1191/MATH/schedule.json?key=secret')
          .to_return(body: fixture('1191_MATH_schedule.json').read)

        in_app_root do
          math_schedule = Subject.find('math').schedule('1191')
          math_schedule.download

          expected = fixture('expected_1191_MATH_schedule.json').read

          assert_equal JSON.parse(expected)['data'], math_schedule.read
        end
      end
    end
  end
end
