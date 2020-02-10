# frozen_string_literal: true

require 'clerk'
require 'clerk/resource/subject_schedule'
require 'date'

module Clerk
  module Resource
    class Term
      attr_reader :year, :month

      class << self
        def today
          today = Date.today
          new(today.year, today.month)
        end

        def next_month
          next_month = Date.today.next_month
          new(next_month.year, next_month.month)
        end
      end

      def initialize(year, month)
        @year = year
        @month = month
      end

      def code
        @code ||= "#{prefix}#{year_last_two_digit}#{term_starting_month}"
      end

      private

      def prefix
        (year / 1000 - 1).to_s
      end

      def year_last_two_digit
        (@year % 100).to_s.rjust(2, '0')
      end

      def term_starting_month
        return '1' if @month < 5
        return '5' if @month < 9

        '9'
      end
    end
  end
end
