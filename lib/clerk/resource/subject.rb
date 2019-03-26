# frozen_string_literal: true

require 'clerk'
require 'clerk/resource/subject_schedule'

module Clerk
  module Resource
    class Subject
      DATA_CSV = Util.data('subjects.csv')

      attr_reader :id

      class << self
        def all
          require 'csv'
          @all ||= CSV.foreach(DATA_CSV, headers: true).map { |row| new(row) }
        end

        def find(id)
          upcase_id = id.upcase
          all.find { |subject| subject.id == upcase_id }
        end
      end

      def initialize(data)
        @id = data['subject']
      end
      private_class_method :new

      def schedule(term)
        @schedule ||= SubjectSchedule.new(subject: self, term: term)
      end
    end
  end
end
