# frozen_string_literal: true

require 'yaml'

module Clerk
  class Settings
    def initialize(root)
      @root = root
      @local_config = load_config(local_config_file)
    end

    def [](name)
      key = key_for(name)

      @local_config.fetch(key) do
        ENV.fetch(key) do
          nil
        end
      end
    end

    def delete_local(key)
      set_local(key, nil)
    end

    def set_local(key, value)
      set(key, value, @local_config, local_config_file)
    end

    private

    def load_config(config_file)
      return {} unless valid_config_file?(config_file)

      YAML.load_file(config_file)
    end

    def local_config_file
      Pathname.new(@root).join('config')
    end

    def valid_config_file?(file)
      file.exist? && !file.size.zero?
    end

    PREFIX = 'CLERK_'

    def key_for(name)
      PREFIX + name.to_s.upcase
    end

    def set(raw_key, value, hash, file)
      key = key_for(raw_key)

      return if hash[key] == value

      hash[key] = value
      hash.delete(key) if value.nil?

      FileUtils.mkdir_p(file.dirname)
      file.open('w') { |f| f.write(hash.to_yaml) }
    end
  end
end
