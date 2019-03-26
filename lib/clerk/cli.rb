# frozen_string_literal: true

require 'thor'
require 'clerk/cli/aggregate'
require 'clerk/cli/download'

module Clerk
  class CLI < Thor
    desc 'aggregate SUBCOMMAND ...ARGS', 'Aggregate data from raw JSON data'
    subcommand 'aggregate', Aggregate

    desc 'download SUBCOMMAND ...ARGS', 'Download raw JSON data from API'
    subcommand 'download', Download
  end
end
