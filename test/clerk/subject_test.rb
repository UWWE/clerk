# frozen_string_literal: true

require 'test_helper'
require 'clerk/resource/subject'

module Clerk
  module Resource
    class SubjectTest < Clerk::TestCase
      test '.all returns all subjects' do
        assert_equal 207, Subject.all.length
      end

      test '.find finds the subject with the given ID' do
        assert Subject.find('MATH')
        assert Subject.find('math')

        refute Subject.find('notvalidsubject')
      end
    end
  end
end
