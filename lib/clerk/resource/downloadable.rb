# frozen_string_literal: true

require 'clerk'
require 'json'

module Clerk
  module Resource
    module Downloadable
      def read
        JSON.parse(File.read(local_json))['data']
      rescue JSON::ParserError
        nil
      end

      def download
        require 'httparty'

        response = HTTParty.get(full_remote_endpoint)

        Util.with_file(local_json) do |file|
          file.write(strip_metadata(response.body))
        end
      end

      private

      def local_json
        raise NotImplementedError
      end

      def remote_endpoint
        raise NotImplementedError
      end

      API_BASE = 'https://api.uwaterloo.ca/v2'

      def full_remote_endpoint
        "#{API_BASE}/#{remote_endpoint}?key=#{Clerk.settings['uw_api_key']}"
      end

      def strip_metadata(raw)
        json = JSON.parse(raw)

        json.delete('meta')

        if data = json['data']
          data.each { |item| item.delete('last_updated') }
        end

        JSON.pretty_generate(json)
      end
    end
  end
end
