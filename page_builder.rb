# frozen_string_literal: true

class PageBuilder
	def self.build_all
		FileUtils.mkdir_p("#{root_path}/dist")

		pages = Dir["#{root_path}/pages/**/*.md"]
		pages.each { |page| new(page).call }
	end

	def self.root_path
		__dir__
	end

	def initialize(page)
		@page = page
	end

	def call
		FileUtils.mkdir_p(directory)
		File.write(file, Components::Page.new(@page).call(view_context: { current_page: path }))
	end

	private

	def file
		"#{directory}/index.html"
	end

	def directory
		"#{PageBuilder.root_path}/dist#{path}"
	end

	def path
		real_path = @page.delete_prefix("#{PageBuilder.root_path}/pages/").delete_suffix(".md").tr("_", "-")
		if real_path == "index"
			"/"
		else
			"/#{real_path}/"
		end
	end
end
