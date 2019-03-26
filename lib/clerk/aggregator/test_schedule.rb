# frozen_string_literal: true

require 'json'
require 'clerk'
require 'clerk/resource/subject'

module Clerk
  module Aggregator
    class TestSchedule
      def initialize(term:)
        @term = term
      end

      protected

      def each
        yield local_json, test_schedule
      end

      private

      def local_json
        Clerk.root.join('aggregated', @term, 'test_schedule.json')
      end

      def test_schedule
        @test_schedule ||= Resource::Subject.all
          .map { |subject| subject.schedule(@term).read }
          .map { |schedule| extract_tests(schedule) }
          .flatten
      end

      def extract_tests(course_schedule)
        course_schedule
          .select { |raw| test?(raw) }
          .map { |raw| transform(raw) }
      end

      def test?(raw)
        raw['section'].start_with?('TST')
      end

      EXTRACTED_KEYS = %w[
        subject
        catalog_number
        enrollment_total
        classes
        academic_level
      ].freeze

      def transform(raw)
        raw.slice(*EXTRACTED_KEYS)
      end
    end
  end
end
