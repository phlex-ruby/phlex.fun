#!/usr/bin/env ruby
# frozen_string_literal: true

$stdout.sync = true

require "bundler"
Bundler.require :default

loader = Zeitwerk::Loader.new
loader.push_dir(__dir__)
loader.enable_reloading
loader.setup

require "minitest"

PageBuilder.build_all

if ARGV.include? "--watch"
	Filewatcher.new(["#{__dir__}/**/*rb", "#{__dir__}/**/*md"]).watch do |_changes|
		loader.reload
		loader.eager_load
		PageBuilder.build_all
	end
end
