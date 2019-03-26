# frozen_string_literal: true

require 'clerk'
require 'json'

module Clerk
  module Aggregator
    class Base
      def aggregate
        each do |local_json, data|
          Util.with_file(local_json) do |file|
            file.write(JSON.pretty_generate(data: data))
          end
        end
      end

      protected

      def each
        raise NotImplementedError
      end
    end
  end
end
