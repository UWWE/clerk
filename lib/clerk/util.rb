# frozen_string_literal: true

require 'pathname'

module Clerk
  module Util
    extend self

    def root
      dotclerk_dir.parent
    rescue DotclerkNotFound
      Pathname.pwd.expand_path
    end

    def data(relative_path)
      File.join(Clerk::ROOT, 'lib', 'data', relative_path)
    end

    def dotclerk_dir
      dotclerk = find_directory('.clerk')
      raise DotclerkNotFound unless dotclerk

      Pathname.new(dotclerk).expand_path
    end

    def with_file(path)
      FileUtils.mkdir_p(File.dirname(path))

      yield File.open(path, 'w')
    end

    private

    def find_file(*names)
      search_up(*names) do |filename|
        return filename if File.file?(filename)
      end
    end

    def find_directory(*names)
      search_up(*names) do |dirname|
        return dirname if File.directory?(dirname)
      end
    end

    def search_up(*names)
      previous = nil
      current = Pathname.pwd

      until !File.directory?(current) || current == previous
        names.each do |name|
          filename = File.join(current, name)
          yield filename
        end

        previous = current
        current = File.expand_path('..', current)
      end
    end
  end
end
