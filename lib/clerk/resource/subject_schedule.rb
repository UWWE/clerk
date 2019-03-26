# frozen_string_literal: true

require 'clerk'
require 'clerk/resource/downloadable'

module Clerk
  module Resource
    class SubjectSchedule
      include Downloadable

      def initialize(term:, subject:)
        @term = term
        @subject = subject
      end

      private

      def local_json
        Clerk.root.join('raw', @term, 'schedule', "#{@subject.id}.json")
      end

      def remote_endpoint
        "terms/#{@term}/#{@subject.id}/schedule.json"
      end
    end
  end
end
