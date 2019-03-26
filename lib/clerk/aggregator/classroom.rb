# frozen_string_literal: true

require 'clerk'
require 'clerk/aggregator/base'
require 'clerk/resource/subject'

module Clerk
  module Aggregator
    class Classroom < Base
      def initialize(term:)
        @term = term
      end

      protected

      def each
        classroom.each do |building, rooms|
          yield local_json_for(building), rooms
        end
      end

      private

      def local_json_for(building)
        Clerk.root.join('aggregated', @term, 'classroom', "#{building}.json")
      end

      def classroom
        return @classroom if @classroom

        @classroom = {}

        Resource::Subject.all.each { |subject| process(subject) }
        sort_by_start_time!

        @classroom
      end

      def process(subject)
        subject.schedule(@term).read.each do |course|
          course['classes'].each do |klass|
            building = klass['location']['building']
            room = klass['location']['room']

            add_class(building, room, course, klass['date']) if building && room
          end
        end
      end

      def add_class(building, room, course, date)
        @classroom[building] ||= {}
        @classroom[building][room] ||= []

        @classroom[building][room] << extract_course(course).merge(extract_date(date))
      end

      def sort_by_start_time!
        @classroom.each do |_, rooms|
          rooms.each do |_, classes|
            classes.sort_by! { |klass| klass['start_time'] }
          end
        end
      end

      def extract_course(course)
        course.slice(
          'subject',
          'catalog_number',
          'title',
          'enrollment_capacity',
          'enrollment_total',
        )
      end

      def extract_date(date)
        date.slice(
          'start_time',
          'end_time',
          'weekdays',
        )
      end
    end
  end
end
