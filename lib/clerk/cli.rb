# frozen_string_literal: true

require 'thor'
require 'clerk/cli/aggregate'
require 'clerk/cli/config'
require 'clerk/cli/download'

module Clerk
  class CLI < Thor
    desc 'aggregate SUBCOMMAND ...ARGS', 'Aggregate data from raw JSON data'
    subcommand 'aggregate', Aggregate

    desc 'config SUBCOMMAND ...ARGS', 'Manipulate Clerk configuration'
    subcommand 'config', Config

    desc 'download SUBCOMMAND ...ARGS', 'Download raw JSON data from API'
    subcommand 'download', Download
  end
end
