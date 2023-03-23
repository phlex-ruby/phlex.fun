# frozen_string_literal: true

module Components
	class Nav < Phlex::HTML
		def template
			nav class: "main-nav flow" do
				render Nav::Group.new "" do |g|
					g.item "Introduction", to: "/"
					g.item "Getting Started", to: "/getting-started/"
					g.item "Basics", to: "/basics/"
					g.item "Elements", to: "/elements/"
					g.item "Hooks & Introspection", to: "/hooks"
					g.item "Helpers", to: "/helpers/"
					g.item "Components", to: "/components/"
				end

				render Nav::Group.new "Rails" do |g|
					g.item "Introduction", to: "/rails/"
					g.item "Generators", to: "/rails/generators/"
					g.item "Rendering views", to: "/rails/rendering-views/"
					g.item "Layouts", to: "/rails/layouts/"
					g.item "Helpers", to: "/rails/helpers/"
					g.item "Migrating to Phlex", to: "/rails/migrating/"
					g.item "Testing", to: "/rails/testing/"
				end

				render Nav::Group.new "Testing" do |g|
					g.item "Introduction", to: "/testing/"
					g.item "Nokogiri", to: "/testing/nokogiri/"
					g.item "Capybara", to: "/testing/capybara/"
					g.item "Rails", to: "/rails/testing/"
				end
			end
		end
	end
end
