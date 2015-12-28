module Jekyll
  module Converters
    class Browserify < Converter
      safe true
      priority :low

      def initialize config
        super
        @browserify = nil

        system "npm install" if npm_install?
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
        if use_nvm?
          @browserify = BrowserifyRb::Nvm::Browserify.new(
            required_modules: nvm_modules,
            browserify_opts: nvm_option,
            nvm_dir: File.join(ENV["PWD"], ".nvm"),
            node_ver: nvm_node_ver
          )
        else
          @browserify = BrowserifyRb::Browserify.new(
            command: command
          )
        end
      end

      def exts
        (config("browserify", "exts") || [".js"]).map(&:downcase)
      end

      def npm_install?
        b = config("browserify", "npm_install")
        (b == true) or (b.is_a? String and b.downcase == "true")
      end

      def command
        config("browserify", "command") || "browserify -"
      end

      def nvm_modules
        config("browserify", "nvm", "modules") || []
      end

      def nvm_option
        config("browserify", "nvm", "option") || ""
      end

      def nvm_node_ver
        config("browserify", "nvm", "node_version")
      end

      def use_nvm?
        not config("browserify", "nvm").nil?
      end

      def config *path
        path.inject(@config) {|c, k| c and c[k] }
      end
    end
  end
end
