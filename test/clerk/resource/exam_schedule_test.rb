# frozen_string_literal: true

require 'test_helper'
require 'clerk/resource/exam_schedule'

module Clerk
  module Resource
    class ExamScheduleTest < Clerk::TestCase
      def setup
        @settings = Clerk::Settings.new(app('.clerk'))
        @settings.set_local('uw_api_key', 'secret')
      end

      test '#download downloads raw JSON data from the API' do
        fixture = fixture('1191_exam_schedule.json').read

        stub_request(:get, 'https://api.uwaterloo.ca/v2/terms/1191/examschedule.json?key=secret')
          .to_return(body: fixture)

        in_app_root do
          exam_schedule = ExamSchedule.new(term: '1191')
          exam_schedule.download

          assert_equal JSON.parse(fixture)['data'], exam_schedule.read
        end
      end
    end
  end
end
