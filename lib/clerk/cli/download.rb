# frozen_string_literal: true

require 'thor'
require 'clerk'

module Clerk
  class CLI < Thor
    class Download < Thor
      desc 'course_schedule TERM', 'Download the course schedules for TERM'
      def course_schedule(term)
        require 'clerk/resource/subject'

        Subject.all.each do |subject|
          subject.schedule(term).download
        end
      end

      desc 'exam_schedule TERM', 'Download the exam schedules for TERM'
      def exam_schedule(term)
        require 'clerk/resource/exam_schedule'

        Resource::ExamSchedule.new(term: term).download
      end
    end
  end
end
