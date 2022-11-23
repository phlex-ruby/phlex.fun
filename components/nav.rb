# frozen_string_literal: true

module Components
	class Nav < Phlex::HTML
		def template
			input type: "checkbox", id: "nav-toggle", class: "flex-0 peer hidden"
			label for: "nav-toggle", class: "top-0 bottom-0 left-0 right-0 bg-gray-900 opacity-0 peer-checked:fixed peer-checked:z-30 peer-checked:block peer-checked:opacity-50 lg:hidden lg:peer-checked:hidden"

			nav do
				guide
				testing
				rails
			end
		end

		private

		def nav
			super(class: "fixed lg:relative w-3/4 border-r-2 border-gray-100 lg:border-0 lg:w-1/4 text-lg lg:text-base h-full z-40 px-10 py-5 -left-full peer-checked:left-0 lg:left-0 bg-white")
		end

		def guide
			render Nav::Group.new("Guide") do |g|
				g.item("Introduction", to: "/")
				g.item("Views", to: "/views/")
				g.item("Templates", to: "/templates/")
				g.item("Helpers", to: "/helpers/")
				g.item("Translations", to: "/translations/")
			end
		end

		def testing
			render Nav::Group.new("Testing") do |g|
				g.item("Getting Started", to: "/testing/getting-started/")
				g.item("Nokogiri", to: "/testing/nokogiri/")
				g.item("Capybara", to: "/testing/capybara/")
				g.item("Rails", to: "/testing/rails/")
			end
		end

		def rails
			render Nav::Group.new("Rails") do |g|
				g.item("Getting started", to: "/rails/getting-started/")
				g.item("Rendering views", to: "/rails/rendering-views/")
				g.item("Layouts", to: "/rails/layouts/")
				g.item("Helpers", to: "/rails/helpers/")
				g.item("Migrating to Phlex", to: "/rails/migrating/")
			end
		end
	end
end
