# frozen_string_literal: true

require 'clerk'

module Clerk
  class CLI < Thor
    class Config < Thor
      desc 'set KEY VALUE', 'Set the config KEY to VALUE'
      def set(key, value)
        Clerk.settings.set_local(key, value)
      end
    end
  end
end
