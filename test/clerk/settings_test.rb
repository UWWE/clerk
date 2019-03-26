# frozen_string_literal: true

require 'test_helper'
require 'clerk/settings'

class Clerk::SettingsTest < Clerk::TestCase
  test '#[] fetches value from config and ENV' do
    settings.delete_local('var')
    ENV.delete('CLERK_VAR')

    assert_nil settings['var']

    ENV['CLERK_VAR'] = 'from env'
    assert_equal 'from env', settings['var']

    settings.set_local('var', 'from local')
    assert_equal 'from local', settings['var']
  end

  private

  def settings
    @settings = Clerk::Settings.new(app('.clerk'))
  end
end
