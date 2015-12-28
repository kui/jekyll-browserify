module Jekyll
  module Converters
    class Browserify < Converter
      safe true
      priority :low

      def initialize config
        super
        @browserify = nil
      end

      def matches ext
        exts.include? ext.downcase
      end

      def output_ext ext
        ".js"
      end

      def convert content
        setup unless @browserify
        @browserify.compile(content)
      end

      def setup
        require "browserify_rb"
        @browserify = BrowserifyRb.new(
          required_modules: modules,
          browserify_opts: option,
          nvm_dir: File.join(ENV["PWD"], ".nvm"),
          node_ver: node_ver
        )
      end

      def exts
        (config("browserify", "exts") || [".js"]).map(&:downcase)
      end

      def modules
        config("browserify", "modules") || []
      end

      def option
        config("browserify", "option") || ""
      end

      def node_ver
        config("browserify", "node_version")
      end

      def config *path
        path.inject(@config) {|c, k| c and c[k] }
      end
    end
  end
end
