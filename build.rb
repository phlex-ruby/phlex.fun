#!/usr/bin/env ruby
# frozen_string_literal: true

$stdout.sync = true

require "bundler"
Bundler.require :default

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}")
loader.enable_reloading
loader.setup

require "minitest"

PageBuilder.build_all
FileUtils.cp_r("#{__dir__}/assets", "#{__dir__}/dist")

if ARGV.include? "--watch"
	Filewatcher.new(["#{__dir__}/**/*rb", "#{__dir__}/**/*md", "#{__dir__}/**/*.css"]).watch do |_changes|
		loader.reload
		PageBuilder.build_all
		FileUtils.cp_r("#{__dir__}/assets", "#{__dir__}/dist")
	end
end
