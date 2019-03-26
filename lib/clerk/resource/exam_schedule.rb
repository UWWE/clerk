# frozen_string_literal: true

require 'clerk'
require 'clerk/resource/downloadable'

module Clerk
  module Resource
    class ExamSchedule
      include Downloadable

      def initialize(term:)
        @term = term
      end

      private

      def local_json
        Clerk.root.join('raw', @term, 'exam_schedule.json')
      end

      def remote_endpoint
        "terms/#{@term}/examschedule.json"
      end
    end
  end
end
