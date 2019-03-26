# frozen_string_literal: true

require 'clerk/version'
require 'clerk/errors'
require 'clerk/settings'

module Clerk
  ROOT = File.expand_path('..', __dir__)

  autoload :Util, 'clerk/util'

  class << self
    def root
      @root ||= Util.root
    end

    def settings
      @settings ||= Settings.new(Util.dotclerk_dir)
    end
  end
end
