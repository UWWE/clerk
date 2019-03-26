# frozen_string_literal: true

require 'clerk'

module Clerk
  class CLI < Thor
    class Aggregate < Thor
      desc 'test_schedule TERM', 'Aggregate the test schedule for TERM'
      def test_schedule(term)
        require 'clerk/aggregator/test_schedule'

        Aggregator::TestSchedule.new(term: term).aggregate
      end

      desc 'classroom TERM', 'Aggregate classroom data for TERM'
      def classroom(term)
        require 'clerk/aggregator/classroom'

        Aggregator::Classroom.new(term: term).aggregate
      end
    end
  end
end
