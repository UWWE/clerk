# frozen_string_literal: true

require 'pathname'

module Clerk
  module Testing
    module Path
      def root
        @root ||= Pathname.new('../../..').expand_path(__FILE__)
      end

      def tmp(*path)
        root.join('tmp', *path)
      end

      def app(*path)
        root = tmp.join('app')
        FileUtils.mkdir_p(root)
        root.join(*path)
      end

      def in_app_root(&blk)
        Dir.chdir(app, &blk)
      end
    end
  end
end
