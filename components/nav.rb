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
				g.item("Introduction", to: Pages::Index, active_page: @_parent)
				g.item("Views", to: Pages::Views, active_page: @_parent)
				g.item("Templates", to: Pages::Templates, active_page: @_parent)
				g.item("Helpers", to: Pages::Helpers, active_page: @_parent)
				g.item("Translations", to: Pages::Translations, active_page: @_parent)
			end
		end

		def testing
			render Nav::Group.new("Testing") do |g|
				g.item("Getting Started", to: Pages::Testing::GettingStarted, active_page: @_parent)
				g.item("Nokogiri", to: Pages::Testing::Nokogiri, active_page: @_parent)
				g.item("Capybara", to: Pages::Testing::Capybara, active_page: @_parent)
				g.item("Rails", to: Pages::Testing::Rails, active_page: @_parent)
			end
		end

		def rails
			render Nav::Group.new("Rails") do |g|
				g.item("Getting started", to: Pages::Rails::GettingStarted, active_page: @_parent)
				g.item("Rendering views", to: Pages::Rails::RenderingViews, active_page: @_parent)
				g.item("Layouts", to: Pages::Rails::Layouts, active_page: @_parent)
				g.item("Helpers", to: Pages::Rails::Helpers, active_page: @_parent)
				g.item("Migrating to Phlex", to: Pages::Rails::Migrating, active_page: @_parent)
			end
		end
	end
end
